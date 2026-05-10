Cypress.Commands.add('visitLetCode', (path, options = {}) => {
  cy.visit(path, {
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
