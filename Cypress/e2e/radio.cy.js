const radioPageUrl = '/radio'

const selectors = {
  pageTitle: 'h1.title',
  yes: '#yes',
  no: '#no',
  one: '#one',
  two: '#two',
  noBug: '#nobug',
  bug: '#bug',
  foo: '#foo',
  notFoo: '#notfoo',
  going: '#going',
  notGoing: '#notG',
  maybe: '#maybe',
  rememberMe: '.field:contains("Find if the checkbox is selected?") input[type="checkbox"]',
  terms: '.field:contains("Accept the T&C") input[type="checkbox"]',
}

describe('LetCode - radio buttons e checkboxes', () => {
  beforeEach(() => {
    cy.visitLetCode(radioPageUrl)
    cy.get(selectors.pageTitle).should('contain.text', 'Radio & Checkbox')
  })

  it('deve selecionar uma opcao no primeiro grupo', () => {
    cy.get(selectors.yes).check().should('be.checked')
    cy.get(selectors.no).should('not.be.checked')
  })

  it('deve permitir apenas uma opcao no grupo de radio buttons', () => {
    cy.get(selectors.one).check().should('be.checked')
    cy.get(selectors.two).should('not.be.checked')

    cy.get(selectors.two).check().should('be.checked')
    cy.get(selectors.one).should('not.be.checked')
  })

  it('deve evidenciar o bug de agrupamento no bloco Find the bug', () => {
    cy.get(selectors.noBug).check().should('be.checked')
    cy.get(selectors.bug).check().should('be.checked')

    cy.get(selectors.noBug).should('be.checked')
    cy.get(selectors.bug).should('be.checked')
  })

  it('deve identificar radio pre-selecionado e opcao desabilitada', () => {
    cy.get(selectors.foo).should('not.be.checked')
    cy.get(selectors.notFoo).should('be.checked')

    cy.get(selectors.going).should('be.enabled')
    cy.get(selectors.notGoing).should('be.enabled')
    cy.get(selectors.maybe).should('be.disabled')
  })

  it('deve validar checkboxes marcados e permitir aceitar os termos', () => {
    cy.get(selectors.rememberMe).should('be.checked')
    cy.get(selectors.terms).should('not.be.checked').check().should('be.checked')
  })
})
