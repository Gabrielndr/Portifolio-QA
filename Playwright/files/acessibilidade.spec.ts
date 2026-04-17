import { test, expect } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';
import { LoginPage, USERS } from '../fixtures';

/**
 * Feature: Acessibilidade — Sauce Demo
 * Cenários BDD usando axe-core para validar conformidade WCAG 2.1.
 * Instalação: npm install -D @axe-core/playwright
 */

test.describe('Acessibilidade', () => {

  test('Dado a página de login, quando analiso com axe, então não deve ter violações críticas', async ({ page }) => {
    // Given
    await page.goto('https://www.saucedemo.com');

    // When
    const results = await new AxeBuilder({ page })
      .withTags(['wcag2a', 'wcag2aa'])
      .analyze();

    // Then
    const criticas = results.violations.filter(v => v.impact === 'critical');
    if (criticas.length > 0) {
      console.log('Violações críticas encontradas:');
      criticas.forEach(v => console.log(`- [${v.id}] ${v.description}`));
    }
    expect(criticas).toHaveLength(0);
  });

  test('Dado a página de inventário, quando analiso com axe, então não deve ter violações críticas', async ({ page }) => {
    // Given
    const loginPage = new LoginPage(page);
    await loginPage.loginAs('standard');

    // When
    const results = await new AxeBuilder({ page })
      .withTags(['wcag2a', 'wcag2aa'])
      .analyze();

    // Then
    const criticas = results.violations.filter(v => v.impact === 'critical');
    expect(criticas).toHaveLength(0);
  });

  test('Dado a página de login, quando verifico contraste de cores, então deve atender WCAG AA', async ({ page }) => {
    // Given
    await page.goto('https://www.saucedemo.com');

    // When
    const results = await new AxeBuilder({ page })
      .withRules(['color-contrast'])
      .analyze();

    // Then
    if (results.violations.length > 0) {
      console.log('Problemas de contraste:');
      results.violations.forEach(v => {
        v.nodes.forEach(n => console.log(`  Elemento: ${n.target}`));
      });
    }
    expect(results.violations).toHaveLength(0);
  });

  test('Dado a página de login, quando verifico navegação por teclado, então os campos devem ser focáveis', async ({ page }) => {
    // Given
    await page.goto('https://www.saucedemo.com');

    // When / Then
    await page.keyboard.press('Tab');
    await expect(page.locator('#user-name')).toBeFocused();

    await page.keyboard.press('Tab');
    await expect(page.locator('#password')).toBeFocused();

    await page.keyboard.press('Tab');
    await expect(page.locator('#login-button')).toBeFocused();
  });

  test('Dado a página de login, quando verifico atributos ARIA, então os campos devem ter labels acessíveis', async ({ page }) => {
    // Given
    await page.goto('https://www.saucedemo.com');

    // Then
    const results = await new AxeBuilder({ page })
      .withRules(['label', 'aria-required-attr', 'aria-valid-attr'])
      .analyze();

    expect(results.violations).toHaveLength(0);
  });

});
