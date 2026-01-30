import http from "k6/http";
import { check, sleep } from "k6";

export const options = {
  stages: [
    { duration: "30s", target: 5 },  // sobe até 5 usuários
    { duration: "1m", target: 5 },   // mantém 5 usuários
    { duration: "30s", target: 0 },  // desce até 0
  ],
  thresholds: {
    http_req_failed: ["rate < 0.05"],       // menos de 5% de erros
    http_req_duration: ["p(95) < 500"],     // 95% das respostas < 500ms
  },
};

export default function () {
  const res = http.get("https://quickpizza.grafana.com"); // substitua pela sua URL de teste

  check(res, {
    "status is 200": (r) => r.status === 200,
    "response body size > 0": (r) => r.body.length > 0,
  });

  sleep(1);
}