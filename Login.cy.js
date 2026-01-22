describe('template spec', () => {
  it('passes', () => {

    cy.viewport(1920, 1080)
    cy.visit('https://letcode.in/home')

    cy.get('.is-inline-flex > :nth-child(2)').click()
    cy.wait(2000)

    cy.get(':nth-child(2) > .control > .input').type('mor_2314')
    cy.wait(2000)

    cy.get(':nth-child(3) > .control > .input').type('83r5^_')
    cy.wait(2000)
    
    cy.get('.button').click()
    
  })
})
