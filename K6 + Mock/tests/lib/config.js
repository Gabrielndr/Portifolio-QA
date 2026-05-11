import { htmlReport } from 'https://raw.githubusercontent.com/benc-uk/k6-reporter/main/dist/bundle.js';

export const BASE_URL = __ENV.BASE_URL || 'http://localhost:8080';
export const REPORT_DIR = __ENV.REPORT_DIR || 'tests/reports';

export const JSON_HEADERS = {
  headers: {
    'Content-Type': 'application/json',
  },
};

export function apiUrl(path) {
  return `${BASE_URL}${path}`;
}

export function parseJson(response) {
  try {
    return response.json();
  } catch (error) {
    return null;
  }
}

export function htmlAndJsonSummary(data, reportName) {
  return {
    [`${REPORT_DIR}/${reportName}.html`]: htmlReport(data),
    [`${REPORT_DIR}/${reportName}.json`]: JSON.stringify(data, null, 2),
  };
}
