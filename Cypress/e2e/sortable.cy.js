import '@4tw/cypress-drag-drop'

describe('template spec', () => {
  it('passes', () => {

    cy.viewport(1920, 1080)
    cy.visit('https://commitquality.com/practice-drag-and-drop')

    cy.get('[data-testid="small-box"]').drag('[data-testid="large-box"]')

    //cy.get('#cdk-drop-list-0 > :nth-child(4)').drag('#cdk-drop-list-1')

    
  })
})