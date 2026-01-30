import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
  vus: 10,         // 10 usuários virtuais
  duration: '15s', // duração total de 15 segundos
};

export default function () {
  http.get('https://quickpizza.grafana.com');
  sleep(1);
}