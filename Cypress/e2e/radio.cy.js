const selectors = {
  checkedRadio: '#my-radio-1',
  defaultRadio: '#my-radio-2',
  checkedCheckbox: '#my-check-1',
  defaultCheckbox: '#my-check-2',
  cheese: '#cheese',
  peas: '#peas',
  cheeseAndPeas: '#cheese_and_peas',
  disabledSnack: '#nothing',
  disabledSelectedRadio: '#lone_disabled_selected_radio',
}

describe('Selenium Web Form - radio buttons e checkboxes', () => {
  beforeEach(() => {
    cy.visitSeleniumPage('web-form.html')
    cy.contains('h1', 'Web form').should('be.visible')
  })

  it('deve permitir apenas uma opcao no grupo de radios', () => {
    cy.get(selectors.checkedRadio).should('be.checked')
    cy.get(selectors.defaultRadio).should('not.be.checked')

    cy.get(selectors.defaultRadio).check().should('be.checked')
    cy.get(selectors.checkedRadio).should('not.be.checked')
  })

  it('deve alternar checkboxes sem afetar radios', () => {
    cy.get(selectors.checkedCheckbox).should('be.checked').uncheck().should('not.be.checked')
    cy.get(selectors.defaultCheckbox).should('not.be.checked').check().should('be.checked')

    cy.get(selectors.checkedRadio).should('be.checked')
  })

  it('deve identificar radio pre-selecionado e opcoes desabilitadas', () => {
    cy.visitSeleniumPage('formPage.html')

    cy.get(selectors.cheeseAndPeas).should('be.checked')
    cy.get(selectors.peas).check().should('be.checked')
    cy.get(selectors.cheeseAndPeas).should('not.be.checked')
    cy.get(selectors.cheese).should('not.be.checked')
    cy.get(selectors.disabledSnack).should('be.disabled')
    cy.get(selectors.disabledSelectedRadio)
      .should('be.disabled')
      .and('be.checked')
  })
})
