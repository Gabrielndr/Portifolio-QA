const BUTTON_PAGE = 'https://the-internet.herokuapp.com/add_remove_elements/'

const selectors = {
  addButton: 'button',
  deleteButton: '.added-manually',
}

const addElements = (quantity) => {
  Cypress._.times(quantity, () => {
    cy.contains(selectors.addButton, 'Add Element')
      .should('be.visible')
      .and('be.enabled')
      .click()
  })
}

describe('The Internet - botoes dinamicos', () => {
  beforeEach(() => {
    cy.visit(BUTTON_PAGE)
    cy.contains('h3', 'Add/Remove Elements').should('be.visible')
  })

  it('deve criar um botao Delete ao acionar Add Element', () => {
    addElements(1)

    cy.get(selectors.deleteButton)
      .should('have.length', 1)
      .and('contain.text', 'Delete')
  })

  it('deve criar multiplos botoes sem sobrescrever os existentes', () => {
    addElements(3)

    cy.get(selectors.deleteButton)
      .should('have.length', 3)
      .each(($button) => {
        expect($button.text().trim()).to.eq('Delete')
      })
  })

  it('deve remover apenas o botao clicado', () => {
    addElements(3)

    cy.get(selectors.deleteButton).eq(1).click()

    cy.get(selectors.deleteButton).should('have.length', 2)
  })
})
