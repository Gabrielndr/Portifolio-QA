import http from 'k6/http';
import { check, group } from 'k6';
import { apiUrl, htmlAndJsonSummary, JSON_HEADERS, parseJson } from './lib/config.js';

http.setResponseCallback(http.expectedStatuses({ min: 200, max: 399 }, 404, 500));

const SUCCESS_PAYLOAD = {
  brand: 'Volkswagen',
  model: 'fusca',
  year: 1965,
};

const ERROR_PAYLOAD = {
  brand: 'Volkswagen',
  model: 'up tsi',
  year: 2020,
};

const NOT_FOUND_PAYLOAD = {
  brand: 'Volkswagen',
  model: 'gol',
  year: 2018,
};

export const options = {
  scenarios: {
    smoke_contract: {
      executor: 'shared-iterations',
      vus: 1,
      iterations: 1,
      maxDuration: '30s',
    },
  },
  thresholds: {
    checks: ['rate==1'],
    http_req_failed: ['rate==0'],
    http_req_duration: ['p(95)<500'],
  },
};

export default function () {
  group('GET /api/cars - listar carros', () => {
    const response = http.get(apiUrl('/api/cars'), {
      tags: { endpoint: 'GET /api/cars' },
    });
    const cars = parseJson(response) || [];

    check(response, {
      'GET /api/cars retorna 200': (res) => res.status === 200,
      'GET /api/cars retorna uma lista': () => Array.isArray(cars),
      'GET /api/cars retorna 5 carros': () => cars.length === 5,
      'GET /api/cars mantem o primeiro carro esperado': () =>
        cars[0] && cars[0].brand === 'Toyota' && cars[0].model === 'Corolla',
      'GET /api/cars mantem o ultimo carro esperado': () =>
        cars[4] && cars[4].brand === 'BMW' && cars[4].model === 'M3',
    });
  });

  group('POST /api/cars - sucesso 201', () => {
    const response = postCar(SUCCESS_PAYLOAD);
    const body = parseJson(response) || {};

    check(response, {
      'POST fusca retorna 201': (res) => res.status === 201,
      'POST fusca retorna mensagem de sucesso': () =>
        body.message === 'Car successfully registered!',
      'POST fusca retorna carId 6': () => body.carId === 6,
    });
  });

  group('POST /api/cars - erro esperado 500', () => {
    const response = postCar(ERROR_PAYLOAD);
    const body = parseJson(response) || {};

    check(response, {
      'POST up tsi retorna 500': (res) => res.status === 500,
      'POST up tsi retorna mensagem de erro': () =>
        body.message === "Internal server error: model 'up tsi' is not allowed.",
    });
  });

  group('POST /api/cars - modelo nao encontrado 404', () => {
    const response = postCar(NOT_FOUND_PAYLOAD);
    const body = parseJson(response) || {};

    check(response, {
      'POST modelo nao mapeado retorna 404': (res) => res.status === 404,
      'POST modelo nao mapeado retorna mensagem correta': () =>
        body.message === 'Car model not found.',
    });
  });
}

function postCar(payload) {
  return http.post(apiUrl('/api/cars'), JSON.stringify(payload), JSON_HEADERS);
}

export function handleSummary(data) {
  return htmlAndJsonSummary(data, 'smoke-contract');
}
