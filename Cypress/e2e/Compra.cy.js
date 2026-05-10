const STORE_PAGE = 'https://letcode.in/home'

const product = {
  id: 1,
  cardTitle: 'Fjallraven - Foldsack No. 1 Ba',
  fullTitle: 'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
  price: '109.95',
}

const openFirstProduct = () => {
  cy.contains('.card', product.cardTitle)
    .should('be.visible')
    .within(() => {
      cy.contains('button', product.price)
        .should('be.visible')
        .and('not.be.disabled')
        .click()
    })

  cy.location('pathname').should('eq', `/product/${product.id}`)
  cy.contains('.title', product.fullTitle).should('be.visible')
}

const addProductToCart = () => {
  openFirstProduct()

  cy.contains('button', 'Add to Cart')
    .should('be.visible')
    .and('not.be.disabled')
    .click()

  cy.window().then((win) => {
    const cart = JSON.parse(win.localStorage.getItem('cart_items') || '[]')

    expect(cart, 'itens no carrinho').to.have.length(1)
    expect(cart[0]).to.include({
      id: product.id,
      title: product.fullTitle,
      quantity: 1,
    })
  })

  cy.get('app-cartvalue .tag.is-success').should('contain.text', '1')
}

const goToCart = () => {
  cy.get('app-cartvalue')
    .find('.fa-cart-shopping')
    .parents('button')
    .should('be.visible')
    .click()

  cy.location('pathname').should('eq', '/cart')
  cy.contains('h2', 'Shopping Cart').should('be.visible')
}

describe('LetCode - fluxo de compra', () => {
  beforeEach(() => {
    cy.viewport(1366, 768)
    cy.visit(STORE_PAGE, {
      onBeforeLoad(win) {
        win.localStorage.clear()
      },
    })
    cy.contains('h1', 'Fake Store').should('be.visible')
    cy.contains('h2', 'Products').should('be.visible')
  })

  it('deve abrir produto, adicionar ao carrinho e exibir badge com quantidade', () => {
    addProductToCart()
  })

  it('deve exibir o produto no carrinho e finalizar checkout com sucesso', () => {
    addProductToCart()
    goToCart()

    cy.contains('td', product.fullTitle).should('be.visible')
    cy.contains('td', `$${product.price}`).should('be.visible')

    cy.on('window:alert', (message) => {
      expect(message).to.eq('Checkout Successful!')
    })

    cy.contains('button', 'Checkout')
      .should('be.visible')
      .and('not.be.disabled')
      .click()

    cy.contains('Your cart is empty').should('be.visible')
    cy.contains('button', 'Continue Shopping').should('be.visible')

    cy.window().then((win) => {
      expect(win.localStorage.getItem('cart_items')).to.be.null
    })
  })
})
