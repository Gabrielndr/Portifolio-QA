describe('template spec', () => {
  it('passes', () => {

   
    cy.viewport(1920, 1080)
    cy.visit('https://letcode.in/home')

    cy.get(':nth-child(1) > .card > .card-footer > .card-footer-item').click()
    cy.wait(2000)

    cy.get('.card-content > .columns > :nth-child(1) > .button').click()
    cy.wait(2000)

    cy.get('.is-inline-flex > :nth-child(1)').click()
    cy.wait(2000)

    cy.get('.has-text-centered > .button').click()
    cy.wait(2000)
    
    cy.get('.ng-star-inserted > .button').click()
    cy.wait(2000)
    
  })
})




