import { test, expect } from './fixtures';

/**
 * Feature: Fluxo de Compra — Sauce Demo
 * Cenários BDD cobrindo adição ao carrinho, checkout e conclusão do pedido.
 */

test.describe('Fluxo de Compra', () => {

  test('Dado que estou no inventário, quando adiciono um produto, então o carrinho deve atualizar', async ({ loggedInPage, inventoryPage }) => {
    // Given (logado via fixture)

    // When
    await inventoryPage.addItemToCart('Sauce Labs Backpack');

    // Then
    expect(await inventoryPage.getCartCount()).toBe('1');
  });

  test('Dado produtos no carrinho, quando acesso o carrinho, então devo ver os itens', async ({ loggedInPage, inventoryPage }) => {
    // Given
    await inventoryPage.addItemToCart('Sauce Labs Backpack');
    await inventoryPage.addItemToCart('Sauce Labs Bike Light');

    // When
    await inventoryPage.goToCart();

    // Then
    await expect(loggedInPage.locator('.cart_item')).toHaveCount(2);
    await expect(loggedInPage.locator('.inventory_item_name').first()).toBeVisible();
  });

  test('Dado carrinho com produto, quando finalizo o checkout, então devo ver confirmação', async ({ loggedInPage, inventoryPage, checkoutPage }) => {
    // Given
    await inventoryPage.addItemToCart('Sauce Labs Backpack');
    await inventoryPage.goToCart();

    // When
    await loggedInPage.click('#checkout');
    await checkoutPage.fillInfo('Gabriel', 'Silva', '01310-100');
    await checkoutPage.finish();

    // Then
    await expect(loggedInPage.locator('.complete-header')).toHaveText('Thank you for your order!');
  });

  test('Dado que estou no inventário, quando ordeno por menor preço, então o primeiro item deve ser o mais barato', async ({ loggedInPage, inventoryPage }) => {
    // Given (logado via fixture)

    // When
    await inventoryPage.sortBy('lohi');

    // Then
    const prices = await loggedInPage.locator('.inventory_item_price').allTextContents();
    const valores = prices.map(p => parseFloat(p.replace('$', '')));
    expect(valores[0]).toBeLessThanOrEqual(valores[1]);
  });

  test('Dado checkout iniciado, quando não preencho os campos, então deve mostrar erro', async ({ loggedInPage, inventoryPage }) => {
    // Given
    await inventoryPage.addItemToCart('Sauce Labs Backpack');
    await inventoryPage.goToCart();
    await loggedInPage.click('#checkout');

    // When
    await loggedInPage.click('#continue');

    // Then
    await expect(loggedInPage.locator('[data-test="error"]')).toContainText('First Name is required');
  });

  test('Dado produto no carrinho, quando removo o item, então o carrinho deve ficar vazio', async ({ loggedInPage, inventoryPage }) => {
    // Given
    await inventoryPage.addItemToCart('Sauce Labs Backpack');
    await inventoryPage.goToCart();

    // When
    await loggedInPage.click('[data-test="remove-sauce-labs-backpack"]');

    // Then
    await expect(loggedInPage.locator('.cart_item')).toHaveCount(0);
    await expect(loggedInPage.locator('.shopping_cart_badge')).not.toBeVisible();
  });

});
