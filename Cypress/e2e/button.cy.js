describe('template spec', () => {
  it('passes', () => {

    cy.viewport(1920, 1080)
    cy.visit('https://letcode.in/button')


    cy.get('#home').click()
    cy.wait(2000)

    cy.go('back')
    cy.wait(2000)

    cy.get('#color').should('have.css', 'background-color', 'rgb(42, 157, 144)')
    cy.wait(2000)

    cy.get('#property').then($el => {
        const largura = $el.width();
        const altura = $el.height();
    cy.log(`Largura: ${largura}px — Altura: ${altura}px`)
  
        expect(largura).to.be.greaterThan(0)
        expect(altura).to.be.greaterThan(0)
    })

    cy.get(':nth-child(6) > .control > #isDisabled').trigger('mousedown', { button: 0 })
    cy.wait(1000)
    
    cy.get(':nth-child(6) > .control > #isDisabled').trigger('mouseup')
    

  })
})