const LOGIN_URL = 'https://the-internet.herokuapp.com/login'

const selectors = {
  username: '#username',
  password: '#password',
  loginButton: 'button[type="submit"]',
  flash: '#flash',
  logout: 'a[href="/logout"]',
}

const credentials = {
  username: 'tomsmith',
  password: 'SuperSecretPassword!',
}

describe('The Internet - login', () => {
  beforeEach(() => {
    cy.visit(LOGIN_URL)
    cy.contains('h2', 'Login Page').should('be.visible')
  })

  it('deve autenticar com credenciais validas', () => {
    cy.get(selectors.username).clear().type(credentials.username)
    cy.get(selectors.password).clear().type(credentials.password, { log: false })
    cy.get(selectors.loginButton).should('be.visible').and('be.enabled').click()

    cy.location('pathname').should('eq', '/secure')
    cy.get(selectors.flash).should('contain.text', 'You logged into a secure area!')
    cy.contains('h2', 'Secure Area').should('be.visible')
    cy.get(selectors.logout).should('be.visible')
  })

  it('nao deve salvar sessao quando a autenticacao falha', () => {
    cy.get(selectors.username).clear().type('usuario_invalido')
    cy.get(selectors.password).clear().type('senha_invalida', { log: false })
    cy.get(selectors.loginButton).should('be.visible').and('be.enabled').click()

    cy.location('pathname').should('eq', '/login')
    cy.get(selectors.flash).should('contain.text', 'Your username is invalid!')
  })
})
