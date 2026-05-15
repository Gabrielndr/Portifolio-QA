// ***********************************************************
// This example support/e2e.js is processed and
// loaded automatically before your test files.
//
// This is a great place to put global configuration and
// behavior that modifies Cypress.
//
// You can change the location of this file or turn off
// automatically serving support files with the
// 'supportFile' configuration option.
//
// You can read more here:
// https://on.cypress.io/configuration
// ***********************************************************

// Import commands.js using ES2015 syntax:
import './commands'

beforeEach(() => {
  [
    '**://www.google-analytics.com/**',
    '**://www.googletagmanager.com/**',
    '**://*.googlesyndication.com/**',
    '**://*.doubleclick.net/**',
  ].forEach((url) => {
    cy.intercept(url, { statusCode: 204, body: '' })
  })
})

Cypress.on('uncaught:exception', (error) => {
  // LetCode occasionally throws this during Angular hydration. It is unrelated to the user flow under test.
  const isKnownLetCodeBootError = error.message.includes(
    "Cannot read properties of null (reading 'document')",
  )

  return !isKnownLetCodeBootError
})
