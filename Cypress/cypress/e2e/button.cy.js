describe('LetCode — Button practice', () => {
  const buttonPageUrl = 'https://letcode.in/button'

  it('navigates home and back, checks color, size, disabled state, and hold', () => {
    cy.viewport(1920, 1080)
    cy.visit(buttonPageUrl)

    cy.get('#home').should('be.visible').click()
    cy.location('pathname').should('eq', '/')

    cy.go('back')
    cy.url().should('include', '/button')

    cy.get('#color').should(
      'have.css',
      'background-color',
      'rgb(42, 157, 144)'
    )

    cy.get('#property')
      .should('be.visible')
      .invoke('width')
      .should('be.greaterThan', 0)
    cy.get('#property').invoke('height').should('be.greaterThan', 0)

    // Page has two elements with id="isDisabled" (invalid HTML); scope explicitly
    cy.get('button#isDisabled[disabled]')
      .should('be.disabled')
      .and('contain.text', 'Disabled')

    const holdButton = () => cy.get('button#isDisabled:not([disabled])')
    holdButton().find('h2').should('contain.text', 'Button Hold!')
    holdButton().find('h2').trigger('mousedown', { button: 0 })
    holdButton().find('h2').trigger('mouseup', { button: 0 })
  })
})
