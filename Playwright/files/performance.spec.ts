import { test, expect, LoginPage, USERS } from '../fixtures';

/**
 * Feature: Performance — Sauce Demo
 * Cenários BDD medindo Web Vitals e tempos de resposta via Performance API.
 * Thresholds baseados nas recomendações do Google Core Web Vitals.
 */

// ─── Thresholds (ms) ────────────────────────────────────────────────────────
const THRESHOLDS = {
  LCP: 2500,   // Largest Contentful Paint  — bom: < 2.5s
  FCP: 1800,   // First Contentful Paint    — bom: < 1.8s
  TTI: 3800,   // Time to Interactive       — bom: < 3.8s
  TBT: 200,    // Total Blocking Time       — bom: < 200ms
  login: 3000, // Tempo total de login
  navigation: 2000, // Navegação entre páginas
};

test.describe('Performance', () => {

  test('Dado a página de login, quando meço o FCP, então deve ser menor que 1800ms', async ({ page }) => {
    // Given / When
    await page.goto('https://www.saucedemo.com');
    await page.waitForLoadState('networkidle');

    // Then
    const fcp = await page.evaluate(() => {
      const entry = performance.getEntriesByName('first-contentful-paint')[0] as PerformanceEntry;
      return entry?.startTime ?? null;
    });

    if (fcp !== null) {
      console.log(`FCP: ${fcp.toFixed(0)}ms (threshold: ${THRESHOLDS.FCP}ms)`);
      expect(fcp).toBeLessThan(THRESHOLDS.FCP);
    } else {
      console.warn('FCP não disponível neste browser');
    }
  });

  test('Dado a página de login, quando meço o LCP, então deve ser menor que 2500ms', async ({ page }) => {
    // Given / When
    await page.goto('https://www.saucedemo.com');
    await page.waitForLoadState('networkidle');

    // Then
    const lcp = await page.evaluate((): Promise<number | null> => {
      return new Promise(resolve => {
        const observer = new PerformanceObserver(list => {
          const entries = list.getEntries();
          const last = entries[entries.length - 1];
          resolve(last?.startTime ?? null);
          observer.disconnect();
        });
        try {
          observer.observe({ type: 'largest-contentful-paint', buffered: true });
          setTimeout(() => resolve(null), 3000);
        } catch {
          resolve(null);
        }
      });
    });

    if (lcp !== null) {
      console.log(`LCP: ${lcp.toFixed(0)}ms (threshold: ${THRESHOLDS.LCP}ms)`);
      expect(lcp).toBeLessThan(THRESHOLDS.LCP);
    } else {
      console.warn('LCP não disponível neste browser');
    }
  });

  test('Dado credenciais válidas, quando meço o tempo de login, então deve ser menor que 3000ms', async ({ page }) => {
    // Given
    const loginPage = new LoginPage(page);
    await loginPage.goto();

    // When
    const inicio = Date.now();
    await loginPage.login(USERS.standard.username, USERS.standard.password);
    await page.waitForURL(/inventory/);
    const duracao = Date.now() - inicio;

    // Then
    console.log(`Tempo de login: ${duracao}ms (threshold: ${THRESHOLDS.login}ms)`);
    expect(duracao).toBeLessThan(THRESHOLDS.login);
  });

  test('Dado que estou logado, quando navego para o carrinho, então deve carregar em menos de 2000ms', async ({ loggedInPage }) => {
    // Given (logado via fixture)

    // When
    const inicio = Date.now();
    await loggedInPage.click('.shopping_cart_link');
    await loggedInPage.waitForURL(/cart/);
    const duracao = Date.now() - inicio;

    // Then
    console.log(`Navegação para carrinho: ${duracao}ms (threshold: ${THRESHOLDS.navigation}ms)`);
    expect(duracao).toBeLessThan(THRESHOLDS.navigation);
  });

  test('Dado a página de inventário, quando analiso o número de requests, então não deve ultrapassar 30', async ({ page }) => {
    // Given
    const requests: string[] = [];
    page.on('request', req => requests.push(req.url()));

    // When
    const loginPage = new LoginPage(page);
    await loginPage.loginAs('standard');
    await page.waitForLoadState('networkidle');

    // Then
    console.log(`Total de requests: ${requests.length}`);
    expect(requests.length).toBeLessThan(30);
  });

  test('Dado usuário performance_glitch_user, quando meço o tempo de login, então deve ser menor que 8000ms', async ({ page }) => {
    // Given — usuário propositalmente lento do Sauce Demo
    const loginPage = new LoginPage(page);
    await loginPage.goto();

    // When
    const inicio = Date.now();
    await loginPage.login(USERS.performance.username, USERS.performance.password);
    await page.waitForURL(/inventory/);
    const duracao = Date.now() - inicio;

    // Then
    console.log(`Tempo de login (glitch user): ${duracao}ms`);
    expect(duracao).toBeLessThan(8000);
  });

});
