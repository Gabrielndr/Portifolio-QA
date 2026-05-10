const DROPDOWN_PAGE = 'https://letcode.in/dropdowns'

const selectors = {
  fruits: '#fruits',
  superHeroes: '#superheros',
  language: '#lang',
  country: '#country',
}

const selectedOptions = (selector) => cy.get(selector).find('option:selected')

describe('LetCode - dropdowns', () => {
  beforeEach(() => {
    cy.viewport(1366, 768)
    cy.visit(DROPDOWN_PAGE)
    cy.contains('h1', 'Dropdown').should('be.visible')
  })

  it('deve selecionar uma fruta pelo texto visivel', () => {
    cy.get(selectors.fruits)
      .should('be.visible')
      .select('Mango')
      .should('have.value', '1')

    selectedOptions(selectors.fruits).should('have.text', 'Mango')
  })

  it('deve permitir selecao multipla de super-herois', () => {
    const heroes = ['The Avengers', 'Batman', 'Iron Man']

    cy.get(selectors.superHeroes)
      .should('be.visible')
      .and('have.attr', 'multiple')

    cy.get(selectors.superHeroes)
      .select(['ta', 'bt', 'im'])

    selectedOptions(selectors.superHeroes).then(($options) => {
      const selectedLabels = [...$options].map((option) => option.text.trim())

      expect(selectedLabels).to.include.members(heroes)
      expect(selectedLabels).to.have.length(heroes.length)
    })
  })

  it('deve selecionar a ultima linguagem e o pais pelo valor correto', () => {
    cy.get(selectors.language)
      .should('be.visible')
      .select('sharp')
      .should('have.value', 'sharp')

    selectedOptions(selectors.language).should('have.text', 'C#')

    cy.get(selectors.country)
      .should('be.visible')
      .select('India')
      .should('have.value', 'India')

    selectedOptions(selectors.country).should('have.text', 'India')
  })
})
