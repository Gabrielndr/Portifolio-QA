const STORE_PAGE = 'https://www.saucedemo.com/'

const product = {
  name: 'Sauce Labs Backpack',
  price: '$29.99',
}

const selectors = {
  username: '#user-name',
  password: '#password',
  login: '#login-button',
  inventoryTitle: '.title',
  productName: '[data-test="inventory-item-name"]',
  productPrice: '[data-test="inventory-item-price"]',
  addBackpack: '[data-test="add-to-cart-sauce-labs-backpack"]',
  cartBadge: '[data-test="shopping-cart-badge"]',
  cartLink: '[data-test="shopping-cart-link"]',
  checkout: '[data-test="checkout"]',
  firstName: '[data-test="firstName"]',
  lastName: '[data-test="lastName"]',
  postalCode: '[data-test="postalCode"]',
  continue: '[data-test="continue"]',
  finish: '[data-test="finish"]',
  completeHeader: '[data-test="complete-header"]',
}

const login = () => {
  cy.visit(STORE_PAGE)
  cy.get(selectors.username).type('standard_user')
  cy.get(selectors.password).type('secret_sauce', { log: false })
  cy.get(selectors.login).click()

  cy.location('pathname').should('include', 'inventory.html')
  cy.get(selectors.inventoryTitle).should('have.text', 'Products')
}

const addBackpackToCart = () => {
  cy.contains(selectors.productName, product.name).should('be.visible')
  cy.contains(selectors.productPrice, product.price).should('be.visible')

  cy.get(selectors.addBackpack)
    .should('be.visible')
    .and('be.enabled')
    .click()

  cy.get(selectors.cartBadge).should('have.text', '1')
}

const goToCart = () => {
  cy.get(selectors.cartLink).click()

  cy.location('pathname').should('include', 'cart.html')
  cy.contains(selectors.productName, product.name).should('be.visible')
}

describe('SauceDemo - fluxo de compra', () => {
  beforeEach(() => {
    login()
  })

  it('deve abrir produto, adicionar ao carrinho e exibir badge com quantidade', () => {
    addBackpackToCart()
  })

  it('deve exibir o produto no carrinho e finalizar checkout com sucesso', () => {
    addBackpackToCart()
    goToCart()

    cy.get(selectors.checkout).click()
    cy.get(selectors.firstName).type('Gabriel')
    cy.get(selectors.lastName).type('Andrade')
    cy.get(selectors.postalCode).type('03554150')
    cy.get(selectors.continue).click()

    cy.location('pathname').should('include', 'checkout-step-two.html')
    cy.contains(selectors.productName, product.name).should('be.visible')
    cy.contains(selectors.productPrice, product.price).should('be.visible')

    cy.get(selectors.finish).click()
    cy.location('pathname').should('include', 'checkout-complete.html')
    cy.get(selectors.completeHeader).should('have.text', 'Thank you for your order!')
  })
})
