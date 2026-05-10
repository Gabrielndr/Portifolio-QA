import '@4tw/cypress-drag-drop'

const dragAndDropPageUrl = 'https://commitquality.com/practice-drag-and-drop'

const selectors = {
  smallBox: '[data-testid="small-box"]',
  largeBox: '[data-testid="large-box"]',
}

describe('CommitQuality - drag and drop', () => {
  beforeEach(() => {
    cy.visit(dragAndDropPageUrl)
  })

  it('deve soltar a caixa pequena na area correta', () => {
    cy.get(selectors.smallBox)
      .should('be.visible')
      .and('have.attr', 'draggable', 'true')

    cy.get(selectors.largeBox)
      .should('be.visible')
      .and('have.text', 'Drag the small box here.')
      .and('not.have.class', 'inside')

    cy.get(selectors.smallBox).drag(selectors.largeBox)

    cy.get(selectors.largeBox)
      .should('have.class', 'inside')
      .and('have.text', 'Success!')
  })
})
