const loginPageUrl = '/login/'
const authUrl = '**/auth/login*'

const selectors = {
  username: 'input[placeholder="Enter Username"]',
  password: 'input[placeholder="Enter Password"]',
  loginButton: 'button.button.is-primary',
}

const credentials = {
  username: 'mor_2314',
  password: '83r5^_',
}

const corsHeaders = {
  'access-control-allow-origin': '*',
  'access-control-allow-methods': 'POST, OPTIONS',
  'access-control-allow-headers': 'content-type',
}

describe('LetCode - login Fake Store', () => {
  beforeEach(() => {
    cy.intercept('OPTIONS', authUrl, {
      statusCode: 204,
      headers: corsHeaders,
    })

    cy.visitLetCode(loginPageUrl, {
      onBeforeLoad(win) {
        win.localStorage.clear()
      },
    })

    cy.contains('h2.title', 'Login').should('be.visible')
  })

  it('deve autenticar com credenciais validas e persistir o token', () => {
    const authToken = 'qa-token'

    cy.intercept('POST', authUrl, {
      statusCode: 200,
      headers: corsHeaders,
      body: { token: authToken },
    }).as('login')

    cy.get(selectors.username).clear().type(credentials.username)
    cy.get(selectors.password).clear().type(credentials.password, { log: false })
    cy.get(selectors.loginButton).scrollIntoView().should('be.visible').and('be.enabled').click()

    cy.wait('@login').then(({ request }) => {
      const body = typeof request.body === 'string'
        ? JSON.parse(request.body)
        : request.body

      expect(body).to.deep.equal(credentials)
    })

    cy.assertPath('/home')
    cy.window().then((win) => {
      expect(win.localStorage.getItem('auth_token')).to.eq(authToken)
      expect(JSON.parse(win.localStorage.getItem('user_data'))).to.deep.eq({
        username: credentials.username,
      })
    })
  })

  it('nao deve salvar sessao quando a autenticacao falha', () => {
    cy.intercept('POST', authUrl, {
      statusCode: 401,
      headers: corsHeaders,
      body: { error: 'Invalid username or password' },
    }).as('loginFailed')

    cy.get(selectors.username).clear().type('usuario_invalido')
    cy.get(selectors.password).clear().type('senha_invalida', { log: false })
    cy.get(selectors.loginButton).scrollIntoView().should('be.visible').and('be.enabled').click()

    cy.wait('@loginFailed')
    cy.assertPath('/login')
    cy.window().then((win) => {
      expect(win.localStorage.getItem('auth_token')).to.be.null
      expect(win.localStorage.getItem('user_data')).to.be.null
    })
  })
})
