import http from 'k6/http';
import { check, sleep } from 'k6';
import { htmlReport } from 'https://raw.githubusercontent.com/benc-uk/k6-reporter/main/dist/bundle.js';

export let options = {
    stages: [
        { duration: '5s', target: 100 },
        { duration: '10s', target: 500 },
        { duration: '5s', target: 100 },
    ],
};


export default function () {
    const url = 'http://localhost:8080/api/cars';  // URL da sua API simulada no Wiremock
    const payload = JSON.stringify({
        brand: 'Volkswagen',
        model: 'fusca',
        year: 1965,
    });
    const params = {
        headers: {
            'Content-Type': 'application/json',
        },
    };
    const response = http.post(url, payload, params);
    // Verifica se o status da resposta é 201 e se a mensagem de sucesso está correta
    check(response, {
        'status is 201': (r) => r.status === 201,
        "message is correct": (r) => r.json('message') === "Car successfully registered!",
        "carId is 6": (r) => r.json('carId') === 6,
    });
    // Aguarda 1 segundo entre as requisições para simular um intervalo
    sleep(1);
}

export function handleSummary(data) {
    return {
        "./report/test-success.html": htmlReport(data),
    }
}