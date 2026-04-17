import { test as base, expect, Page } from '@playwright/test';

// ─── Credenciais ───────────────────────────────────────────────────────────────
export const USERS = {
  standard:  { username: 'standard_user',        password: 'secret_sauce' },
  locked:    { username: 'locked_out_user',       password: 'secret_sauce' },
  problem:   { username: 'problem_user',          password: 'secret_sauce' },
  performance: { username: 'performance_glitch_user', password: 'secret_sauce' },
};

// ─── Page Object: Login ────────────────────────────────────────────────────────
export class LoginPage {
  constructor(private page: Page) {}

  async goto() {
    await this.page.goto('/');
  }

  async login(username: string, password: string) {
    await this.page.fill('#user-name', username);
    await this.page.fill('#password', password);
    await this.page.click('#login-button');
  }

  async loginAs(user: keyof typeof USERS) {
    await this.goto();
    await this.login(USERS[user].username, USERS[user].password);
  }
}

// ─── Page Object: Inventário ───────────────────────────────────────────────────
export class InventoryPage {
  constructor(private page: Page) {}

  async addItemToCart(itemName: string) {
    const slug = itemName.toLowerCase().replace(/\s+/g, '-').replace(/[()]/g, '');
    await this.page.click(`[data-test="add-to-cart-${slug}"]`);
  }

  async getCartCount(): Promise<string | null> {
    return this.page.locator('.shopping_cart_badge').textContent();
  }

  async goToCart() {
    await this.page.click('.shopping_cart_link');
  }

  async sortBy(option: 'az' | 'za' | 'lohi' | 'hilo') {
    await this.page.selectOption('.product_sort_container', option);
  }
}

// ─── Page Object: Checkout ─────────────────────────────────────────────────────
export class CheckoutPage {
  constructor(private page: Page) {}

  async fillInfo(firstName: string, lastName: string, zip: string) {
    await this.page.fill('#first-name', firstName);
    await this.page.fill('#last-name', lastName);
    await this.page.fill('#postal-code', zip);
    await this.page.click('#continue');
  }

  async finish() {
    await this.page.click('#finish');
  }
}

// ─── Fixture com Page Objects ──────────────────────────────────────────────────
type Fixtures = {
  loginPage: LoginPage;
  inventoryPage: InventoryPage;
  checkoutPage: CheckoutPage;
  loggedInPage: Page;
};

export const test = base.extend<Fixtures>({
  loginPage: async ({ page }, use) => {
    await use(new LoginPage(page));
  },
  inventoryPage: async ({ page }, use) => {
    await use(new InventoryPage(page));
  },
  checkoutPage: async ({ page }, use) => {
    await use(new CheckoutPage(page));
  },
  loggedInPage: async ({ page }, use) => {
    const loginPage = new LoginPage(page);
    await loginPage.loginAs('standard');
    await use(page);
  },
});

export { expect };
