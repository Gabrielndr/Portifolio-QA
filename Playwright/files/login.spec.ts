import { test, expect, USERS } from './fixtures';

/**
 * Feature: Autenticação — Sauce Demo
 * Cenários BDD cobrindo login válido, inválido e usuário bloqueado.
 */

test.describe('Login', () => {

  test('Dado que acesso a página, deve exibir o formulário de login', async ({ loginPage, page }) => {
    // Given
    await loginPage.goto();

    // Then
    await expect(page.locator('#user-name')).toBeVisible();
    await expect(page.locator('#password')).toBeVisible();
    await expect(page.locator('#login-button')).toBeVisible();
  });

  test('Dado credenciais válidas, quando faço login, então devo acessar o inventário', async ({ loginPage, page }) => {
    // Given
    await loginPage.goto();

    // When
    await loginPage.login(USERS.standard.username, USERS.standard.password);

    // Then
    await expect(page).toHaveURL(/inventory/);
    await expect(page.locator('.title')).toHaveText('Products');
  });

  test('Dado usuário bloqueado, quando faço login, então devo ver mensagem de erro', async ({ loginPage, page }) => {
    // Given
    await loginPage.goto();

    // When
    await loginPage.login(USERS.locked.username, USERS.locked.password);

    // Then
    await expect(page.locator('[data-test="error"]')).toBeVisible();
    await expect(page.locator('[data-test="error"]')).toContainText('locked out');
  });

  test('Dado senha incorreta, quando faço login, então devo ver mensagem de erro', async ({ loginPage, page }) => {
    // Given
    await loginPage.goto();

    // When
    await loginPage.login(USERS.standard.username, 'senha_errada');

    // Then
    await expect(page.locator('[data-test="error"]')).toBeVisible();
    await expect(page.locator('[data-test="error"]')).toContainText('Username and password do not match');
  });

  test('Dado campos vazios, quando clico em login, então deve exibir erro de validação', async ({ loginPage, page }) => {
    // Given
    await loginPage.goto();

    // When
    await page.click('#login-button');

    // Then
    await expect(page.locator('[data-test="error"]')).toContainText('Username is required');
  });

  test('Dado que estou logado, quando clico em logout, então devo voltar à tela de login', async ({ loggedInPage }) => {
    // Given (já logado via fixture)

    // When
    await loggedInPage.click('#react-burger-menu-btn');
    await loggedInPage.click('#logout_sidebar_link');

    // Then
    await expect(loggedInPage).toHaveURL('/');
    await expect(loggedInPage.locator('#login-button')).toBeVisible();
  });

});
