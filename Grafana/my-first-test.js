import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
  iterations: 10, // executa 10 vezes
};

export default function () {
  http.get('https://quickpizza.grafana.com'); // URL exemplo
  sleep(1); // pausa 1 segundo entre as requisições
}

