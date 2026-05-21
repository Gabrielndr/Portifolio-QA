const SELENIUM_WEB_BASE_URL = 'https://www.selenium.dev/selenium/web'

Cypress.Commands.add('visitSeleniumPage', (page, options = {}) => {
  const normalizedPage = page.replace(/^\/+/, '')

  cy.visit(`${SELENIUM_WEB_BASE_URL}/${normalizedPage}`, {
    retryOnNetworkFailure: true,
    retryOnStatusCodeFailure: true,
    timeout: 120000,
    ...options,
  })
})

Cypress.Commands.add('assertPath', (expectedPath) => {
  const normalizePath = (path) => (path === '/' ? path : path.replace(/\/$/, ''))

  cy.location('pathname', { timeout: 15000 }).should((currentPath) => {
    expect(normalizePath(currentPath)).to.eq(normalizePath(expectedPath))
  })
})
