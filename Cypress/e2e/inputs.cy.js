const selectors = {
  pageTitle: 'h1',
  text: '#my-text-id',
  password: 'input[name="my-password"]',
  textarea: 'textarea[name="my-textarea"]',
  disabled: 'input[name="my-disabled"]',
  readOnly: 'input[name="my-readonly"]',
  date: 'input[name="my-date"]',
  range: 'input[name="my-range"]',
}

describe('Selenium Web Form - campos de input', () => {
  beforeEach(() => {
    cy.visitSeleniumPage('web-form.html')
    cy.get(selectors.pageTitle).should('contain.text', 'Web form')
  })

  it('deve preencher textos e navegar entre campos com TAB', () => {
    const fullName = 'Gabriel da Silva Andrade'

    cy.get(selectors.text)
      .clear()
      .type(fullName)
      .should('have.value', fullName)

    cy.get(selectors.password)
      .type('senha-temporaria', { log: false })
      .should('have.value', 'senha-temporaria')

    cy.get(selectors.textarea)
      .type('Texto em campo multilinha')
      .should('have.value', 'Texto em campo multilinha')

    cy.press(Cypress.Keyboard.Keys.TAB)
    cy.get(selectors.disabled).should('not.be.focused')
  })

  it('deve validar campos disabled e readonly', () => {
    cy.get(selectors.disabled)
      .should('be.disabled')
      .and('have.attr', 'disabled')

    cy.get(selectors.readOnly)
      .should('have.value', 'Readonly input')
      .and('have.attr', 'readonly')
  })

  it('deve manipular data e range sem alterar o layout', () => {
    cy.get(selectors.date)
      .clear()
      .type('05/21/2026')
      .blur()
      .should('have.value', '05/21/2026')

    cy.get(selectors.range)
      .invoke('val', '9')
      .trigger('input', { force: true })
      .trigger('change', { force: true })
      .should('have.value', '9')
  })
})
