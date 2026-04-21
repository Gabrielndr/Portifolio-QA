

describe('template spec', () => {
  it('passes', () => {

    cy.viewport(1920, 1080)
    cy.visit('https://letcode.in/dropdowns')

    cy.get('#fruits').select('Mango')

    cy.get('#superheros').select('The Avengers')

    cy.get('#lang').select('Python').then(($select) => {
        const valorSelecionado = $select.val(); // Pega o valor da opção atualmente selecionada
    cy.wrap($select).find('option').each(($option, index) => {
        const valor = $option.attr('value')
        const texto = $option.text() 
          if (valor === valorSelecionado) { 
              cy.log(`👉 Opção ${index + 1}: "${texto}" (selecionada)`)
          } else {
               cy.log(`Opção ${index + 1}: "${texto}"`)
          }
      })
    })
    cy.get('#country').select('Brazil') .invoke('val').then((valorSelecionado) => {
    cy.log('País selecionado: ' + valorSelecionado)
    })
  })
})



