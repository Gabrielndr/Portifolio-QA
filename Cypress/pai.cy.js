describe('template spec', () => {
  it('passes', () => {

    cy.viewport(1920, 1080)
    cy.visit('www.enel.com.br/pt-saopaulo.html')

    cy.get('#truste-consent-button').click()
    cy.get('a.latam-btn-cta.selectbrazilregion[data-loc-path="https://www.enel.com.br/pt-saopaulo"]').click()
    cy.get('.group.bg-gray > #carousel-home-module > .hub_inner_mobile > .swiper-container > .swiper-wrapper > :nth-child(3) > .module-content > .tile > .tile_inner > .tile_image-wrapper').click()
    cy.get('button[data-control]')
  .contains('Normas Técnicas Locais')
  .click();
    cy.get('.open > [data-content=""] > .item-data > :nth-child(1) > .anchor > .component > .rich-text_inner > :nth-child(18) > a').click()
  })
})