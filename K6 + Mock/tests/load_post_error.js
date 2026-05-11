import http from 'k6/http';
import { check, sleep } from 'k6';
import { apiUrl, htmlAndJsonSummary, JSON_HEADERS, parseJson } from './lib/config.js';

http.setResponseCallback(http.expectedStatuses(500));

const VUS = Number(__ENV.VUS || 10);
const DURATION = __ENV.DURATION || '30s';
const PAYLOAD = {
  brand: 'Volkswagen',
  model: 'up tsi',
  year: 2020,
};

export const options = {
  scenarios: {
    post_error_load: {
      executor: 'constant-vus',
      vus: VUS,
      duration: DURATION,
    },
  },
  thresholds: {
    checks: ['rate>0.99'],
    http_req_failed: ['rate==0'],
    http_req_duration: ['p(95)<800'],
  },
};

export default function () {
  const response = http.post(apiUrl('/api/cars'), JSON.stringify(PAYLOAD), {
    ...JSON_HEADERS,
    tags: { endpoint: 'POST /api/cars - 500' },
  });
  const body = parseJson(response) || {};

  check(response, {
    'POST up tsi retorna 500': (res) => res.status === 500,
    'POST up tsi retorna mensagem de erro': () =>
      body.message === "Internal server error: model 'up tsi' is not allowed.",
  });

  sleep(1);
}

export function handleSummary(data) {
  return htmlAndJsonSummary(data, 'load-post-error');
}
