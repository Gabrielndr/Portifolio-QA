const BUTTON_PAGE = 'https://letcode.in/button'

const selectors = {
  home: '#home',
  position: '#position',
  color: '#color',
  property: '#property',
  disabled: '#isDisabled',
}

describe('LetCode - botoes', () => {
  beforeEach(() => {
    cy.viewport(1366, 768)
    cy.visit(BUTTON_PAGE)
  })

  it('deve navegar para a home e voltar para a pagina de botoes', () => {
    cy.get(selectors.home)
      .should('be.visible')
      .and('not.be.disabled')
      .click()

    cy.location('pathname').should('not.eq', '/button')

    cy.go('back')

    cy.location('pathname').should('eq', '/button')
    cy.get(selectors.home).should('be.visible')
  })

  it('deve exibir posicao, cor e dimensoes esperadas dos botoes', () => {
    cy.get(selectors.position).should(($button) => {
      const { x, y } = $button[0].getBoundingClientRect()

      expect(x, 'posicao horizontal').to.be.greaterThan(0)
      expect(y, 'posicao vertical').to.be.greaterThan(0)
    })

    cy.get(selectors.color)
      .should('be.visible')
      .and('have.css', 'background-color', 'rgb(42, 157, 144)')

    cy.get(selectors.property).should(($button) => {
      const { width, height } = $button[0].getBoundingClientRect()

      expect(width, 'largura').to.be.greaterThan(0)
      expect(height, 'altura').to.be.greaterThan(0)
    })
  })

  it('deve manter o botao desabilitado sem permitir clique do usuario', () => {
    cy.get(selectors.disabled)
      .should('be.visible')
      .and('be.disabled')
  })
})
