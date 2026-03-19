describe('template spec', () => {
  it('passes', () => {

    cy.viewport(1920, 1080)
    cy.visit('https://letcode.in/edit')

    cy.get('#fullName').type('Gabriel da Silva Andrade')
    cy.wait(2000)
    cy.get('#join').clear()
    cy.wait(2000)
    cy.get('#join').type('Treinando')
    cy.wait(2000)
    cy.press(Cypress.Keyboard.Keys.TAB) 
    cy.wait(2000)
    cy.get('#getMe').should('have.value', 'ortonikc')
    cy.wait(2000)
    cy.get('#clearMe').clear()
    cy.wait(2000)
    cy.get('#noEdit').should('not.have.attr', 'readonly')
     cy.wait(2000)
    cy.get('#dontwrite').should('have.attr', 'readonly')
    
  })
})
