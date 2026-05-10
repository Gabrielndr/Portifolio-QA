Cypress.Commands.add('visitLetCode', (path, options = {}) => {
  cy.visit(path, options)
})

Cypress.Commands.add('assertPath', (expectedPath) => {
  const normalizePath = (path) => (path === '/' ? path : path.replace(/\/$/, ''))

  cy.location('pathname').should((currentPath) => {
    expect(normalizePath(currentPath)).to.eq(normalizePath(expectedPath))
  })
})
