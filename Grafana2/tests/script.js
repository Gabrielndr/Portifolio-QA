import http from 'k6/http';
import { check, sleep } from 'k6';


export const options = {
    vus: 10, // Define 10 usuários virtuais simultâneos
    duration: '30s', // Executa o teste por 30 segundos

};

export default function () {
    const url = 'http://localhost:8080/api/cars';  // URL da sua API simulada no Wiremock
    const payload = JSON.stringify({
        brand: 'Volkswagen',
        model: 'up tsi',
        year: 2020,
    });
    const params = {
        headers: {
            'Content-Type': 'application/json',
        },
    };
    const response = http.post(url, payload, params);
    // Verifica se o status da resposta é 500 e se a mensagem de erro está correta
    check(response, {
        'status is 500 ': (r) => r.status === 500,
        "error message is correct ": (r) => r.json('message') === "Internal server error: model 'up tsi' is not allowed.",
    });
    // Aguarda 1 segundo entre as requisições para simular um intervalo
    sleep(1);


}