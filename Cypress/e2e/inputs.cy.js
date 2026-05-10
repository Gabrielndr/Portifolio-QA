const editPageUrl = 'https://letcode.in/edit'

const selectors = {
  pageTitle: 'h1.title',
  fullName: '#fullName',
  join: '#join',
  getMe: '#getMe',
  clearMe: '#clearMe',
  noEdit: '#noEdit',
  readOnly: '#dontwrite',
}

describe('LetCode - campos de input', () => {
  beforeEach(() => {
    cy.viewport(1366, 768)
    cy.visit(editPageUrl)
    cy.get(selectors.pageTitle).should('contain.text', 'Input')
  })

  it('deve preencher o nome completo e usar TAB para navegar entre campos', () => {
    const fullName = 'Gabriel da Silva Andrade'

    cy.get(selectors.fullName)
      .clear()
      .type(fullName)
      .should('have.value', fullName)

    cy.get(selectors.join)
      .should('have.value', 'I am good')
      .type(' Treinando')
      .should('have.value', 'I am good Treinando')

    cy.press(Cypress.Keyboard.Keys.TAB)
    cy.get(selectors.getMe).should('be.focused')
  })

  it('deve validar valor pre-carregado, limpeza e bloqueios dos campos', () => {
    cy.get(selectors.getMe).should('have.value', 'ortonikc')

    cy.get(selectors.clearMe)
      .should('have.value', 'Koushik Chatterjee')
      .clear()
      .should('have.value', '')

    cy.get(selectors.noEdit)
      .should('be.disabled')
      .and('have.attr', 'disabled')

    cy.get(selectors.readOnly)
      .should('have.value', 'This text is readonly')
      .and('have.attr', 'readonly')
  })
})
