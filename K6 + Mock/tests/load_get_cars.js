import http from 'k6/http';
import { check, sleep } from 'k6';
import { apiUrl, htmlAndJsonSummary, parseJson } from './lib/config.js';

const VUS = Number(__ENV.VUS || 5);
const DURATION = __ENV.DURATION || '20s';

export const options = {
  scenarios: {
    get_cars_load: {
      executor: 'constant-vus',
      vus: VUS,
      duration: DURATION,
    },
  },
  thresholds: {
    checks: ['rate>0.99'],
    http_req_failed: ['rate<0.01'],
    http_req_duration: ['p(95)<500'],
  },
};

export default function () {
  const response = http.get(apiUrl('/api/cars'), {
    tags: { endpoint: 'GET /api/cars' },
  });
  const cars = parseJson(response) || [];

  check(response, {
    'GET /api/cars retorna 200': (res) => res.status === 200,
    'GET /api/cars retorna 5 carros': () => Array.isArray(cars) && cars.length === 5,
    'GET /api/cars contem Toyota Corolla': () =>
      cars.some((car) => car.brand === 'Toyota' && car.model === 'Corolla'),
    'GET /api/cars contem BMW M3': () =>
      cars.some((car) => car.brand === 'BMW' && car.model === 'M3'),
  });

  sleep(1);
}

export function handleSummary(data) {
  return htmlAndJsonSummary(data, 'load-get-cars');
}
