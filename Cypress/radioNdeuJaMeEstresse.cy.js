describe('template spec', () => {
  it('passes', () => {

    cy.viewport(1920, 1080)
    cy.visit('https://letcode.in/radio')
    

    cy.get('#yes').check()

    cy.get('#one').check()
    cy.get('#one').should('be.checked')
    cy.get('#two').should('have.length', 1)

    cy.get('input[type="radio"][value="nobug"]').check()
    cy.get('input[type="radio"][value="bug"]').check()

      // Verifica se AMBAS estão marcadas — o que não deveria acontecer!
    cy.get('input[type="radio"][value="nobug"]').should('be.checked')
    cy.get('input[type="radio"][value="bug"]').should('be.checked') // Isso indica o bug

      })
})