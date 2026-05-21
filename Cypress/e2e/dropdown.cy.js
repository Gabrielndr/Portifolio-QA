const selectors = {
  select: 'select[name="my-select"]',
  datalist: 'input[name="my-datalist"]',
  datalistOptions: '#my-options option',
  multiSelect: '#selectWithMultipleLongList',
}

const selectedOptions = (selector) => cy.get(selector).find('option:selected')

describe('Selenium Web Form - dropdowns', () => {
  beforeEach(() => {
    cy.visitSeleniumPage('web-form.html')
    cy.contains('h1', 'Web form').should('be.visible')
  })

  it('deve selecionar uma opcao pelo texto visivel', () => {
    cy.get(selectors.select)
      .should('be.visible')
      .select('Two')
      .should('have.value', '2')

    selectedOptions(selectors.select).should('have.text', 'Two')
  })

  it('deve preencher um datalist com opcao conhecida', () => {
    cy.get(selectors.datalistOptions)
      .should('have.length', 5)
      .then(($options) => {
        const values = [...$options].map((option) => option.value)

        expect(values).to.include.members(['San Francisco', 'New York', 'Seattle'])
      })

    cy.get(selectors.datalist)
      .clear()
      .type('Seattle')
      .should('have.value', 'Seattle')
  })

  it('deve permitir selecao multipla em componente dedicado', () => {
    const selectedItems = ['one', 'three', 'five']

    cy.visitSeleniumPage('selectPage.html')

    cy.get(selectors.multiSelect)
      .should('be.visible')
      .and('have.attr', 'multiple')

    cy.get(selectors.multiSelect).select(selectedItems)

    selectedOptions(selectors.multiSelect).then(($options) => {
      const values = [...$options].map((option) => option.text.trim())

      expect(values).to.deep.eq(selectedItems)
    })
  })
})
