import { test, expect } from '@playwright/test';

/**
 * Feature: API REST — ServeRest
 * Cenários BDD cobrindo CRUD de produtos e usuários com autenticação JWT.
 * Base URL: https://serverest.dev
 */

const BASE_URL = 'https://serverest.dev';
let token: string;
let produtoId: string;
let usuarioId: string;

test.describe('API — Autenticação', () => {

  test('Dado credenciais válidas, quando faço POST em /login, então recebo token JWT', async ({ request }) => {
    // Given / When
    const res = await request.post(`${BASE_URL}/login`, {
      data: { email: 'fulano@qa.com.br', password: 'teste' },
    });

    // Then
    expect(res.status()).toBe(200);
    const body = await res.json();
    expect(body).toHaveProperty('authorization');
    token = body.authorization;
  });

});

test.describe('API — Usuários', () => {

  test.beforeAll(async ({ request }) => {
    const res = await request.post(`${BASE_URL}/login`, {
      data: { email: 'fulano@qa.com.br', password: 'teste' },
    });
    token = (await res.json()).authorization;
  });

  test('Dado que faço GET em /usuarios, então deve retornar lista de usuários', async ({ request }) => {
    const res = await request.get(`${BASE_URL}/usuarios`);
    expect(res.status()).toBe(200);
    const body = await res.json();
    expect(body).toHaveProperty('usuarios');
    expect(Array.isArray(body.usuarios)).toBeTruthy();
  });

  test('Dado payload válido, quando faço POST em /usuarios, então deve criar o usuário', async ({ request }) => {
    const payload = {
      nome: 'QA Playwright',
      email: `qa_playwright_${Date.now()}@teste.com`,
      password: 'teste123',
      administrador: 'true',
    };

    const res = await request.post(`${BASE_URL}/usuarios`, { data: payload });
    expect(res.status()).toBe(201);
    const body = await res.json();
    expect(body.message).toBe('Cadastro realizado com sucesso');
    usuarioId = body._id;
  });

  test('Dado um usuário existente, quando faço DELETE, então deve remover com sucesso', async ({ request }) => {
    const res = await request.delete(`${BASE_URL}/usuarios/${usuarioId}`);
    expect(res.status()).toBe(200);
    const body = await res.json();
    expect(body.message).toBe('Registro excluído com sucesso');
  });

});

test.describe('API — Produtos', () => {

  test.beforeAll(async ({ request }) => {
    const res = await request.post(`${BASE_URL}/login`, {
      data: { email: 'fulano@qa.com.br', password: 'teste' },
    });
    token = (await res.json()).authorization;
  });

  test('Dado que faço GET em /produtos, então deve retornar lista de produtos', async ({ request }) => {
    const res = await request.get(`${BASE_URL}/produtos`);
    expect(res.status()).toBe(200);
    const body = await res.json();
    expect(body).toHaveProperty('produtos');
  });

  test('Dado payload e token válidos, quando faço POST em /produtos, então deve criar o produto', async ({ request }) => {
    const payload = {
      nome: `Produto Playwright ${Date.now()}`,
      preco: 299,
      descricao: 'Criado via teste automatizado Playwright',
      quantidade: 10,
    };

    const res = await request.post(`${BASE_URL}/produtos`, {
      data: payload,
      headers: { Authorization: token },
    });

    expect(res.status()).toBe(201);
    const body = await res.json();
    expect(body.message).toBe('Cadastro realizado com sucesso');
    produtoId = body._id;
  });

  test('Dado produto existente, quando faço PUT, então deve atualizar com sucesso', async ({ request }) => {
    const payload = {
      nome: `Produto Atualizado ${Date.now()}`,
      preco: 399,
      descricao: 'Atualizado via Playwright',
      quantidade: 5,
    };

    const res = await request.put(`${BASE_URL}/produtos/${produtoId}`, {
      data: payload,
      headers: { Authorization: token },
    });

    expect(res.status()).toBe(200);
    const body = await res.json();
    expect(body.message).toBe('Registro alterado com sucesso');
  });

  test('Dado produto existente, quando faço DELETE, então deve remover com sucesso', async ({ request }) => {
    const res = await request.delete(`${BASE_URL}/produtos/${produtoId}`, {
      headers: { Authorization: token },
    });

    expect(res.status()).toBe(200);
    const body = await res.json();
    expect(body.message).toBe('Registro excluído com sucesso');
  });

  test('Dado requisição sem token, quando faço POST em /produtos, então deve retornar 401', async ({ request }) => {
    const res = await request.post(`${BASE_URL}/produtos`, {
      data: { nome: 'Sem auth', preco: 10, descricao: 'x', quantidade: 1 },
    });
    expect(res.status()).toBe(401);
  });

});
