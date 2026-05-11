import http from 'k6/http';
import { check, sleep } from 'k6';
import { apiUrl, htmlAndJsonSummary, JSON_HEADERS, parseJson } from './lib/config.js';

const PROFILE = (__ENV.PROFILE || 'portfolio').toLowerCase();
const STAGES =
  PROFILE === 'smoke'
    ? [
        { duration: '2s', target: 1 },
        { duration: '1s', target: 0 },
      ]
    : [
        { duration: '5s', target: 100 },
        { duration: '10s', target: 500 },
        { duration: '5s', target: 100 },
      ];

const PAYLOAD = {
  brand: 'Volkswagen',
  model: 'fusca',
  year: 1965,
};

export const options = {
  scenarios: {
    post_success_stress: {
      executor: 'ramping-vus',
      stages: STAGES,
      gracefulRampDown: '5s',
    },
  },
  thresholds: {
    checks: ['rate>0.99'],
    http_req_failed: ['rate<0.01'],
    http_req_duration: ['p(95)<800'],
  },
};

export default function () {
  const response = http.post(apiUrl('/api/cars'), JSON.stringify(PAYLOAD), {
    ...JSON_HEADERS,
    tags: { endpoint: 'POST /api/cars - 201' },
  });
  const body = parseJson(response) || {};

  check(response, {
    'POST fusca retorna 201': (res) => res.status === 201,
    'POST fusca retorna mensagem de sucesso': () =>
      body.message === 'Car successfully registered!',
    'POST fusca retorna carId 6': () => body.carId === 6,
  });

  sleep(1);
}

export function handleSummary(data) {
  return htmlAndJsonSummary(data, 'stress-post-success');
}
