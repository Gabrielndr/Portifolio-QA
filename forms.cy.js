describe('template spec', () => {
  it('passes', () => {

    cy.viewport(1920, 1080)
    cy.visit('https://letcode.in/forms')   
    
    cy.get('#firstname').type('Gabriel')
    cy.get('#lasttname').type('da Silva Andrade')
    cy.get('#email').clear()
    cy.get('#email').type('gabriel.2001.2308@gmail.com')
    cy.get(':nth-child(2) > :nth-child(2) > .field > .control > .select > select').select('55')
    cy.get('#Phno').type('11 942528073')
    cy.get('#Addl1').type('Rua bala mineira')
    cy.get('#Addl2').type('Rua das violetass')
    cy.get('#state').type('São Paulo')
    cy.get('#postalcode').type('03554-150')
    cy.get(':nth-child(5) > :nth-child(2) > .field > .control > .select > select').select('Brazil')
    cy.get('#Date').clear().type('2021-08-23')
    cy.get('#female').click()
    cy.get('.checkbox > input').click()
    cy.get('.control > .button').click()

    })
  })