const FORM_PAGE = 'https://letcode.in/forms'

const selectors = {
  firstName: '#firstname',
  lastName: '#lasttname',
  email: '#email',
  phone: '#Phno',
  addressLine1: '#Addl1',
  addressLine2: '#Addl2',
  state: '#state',
  postalCode: '#postalcode',
  birthDate: '#Date',
  female: '#female',
  terms: '.checkbox input[type="checkbox"]',
  submit: 'input[type="submit"]',
}

const validUser = {
  firstName: 'Gabriel',
  lastName: 'da Silva Andrade',
  email: 'gabriel.qa@example.com',
  countryCode: '55',
  phone: '1194258073',
  addressLine1: 'Rua das Flores',
  addressLine2: 'Apto 12',
  state: 'Sao Paulo',
  postalCode: '03554150',
  country: 'Brazil',
  birthDate: '2001-08-23',
}

const invalidEmail = 'email-sem-arroba'

const selectByLabel = (label) => (
  cy.contains('label', new RegExp(`^${label}$`))
    .parents('.field')
    .find('select')
)

const fillValidForm = () => {
  cy.get(selectors.firstName).clear().type(validUser.firstName)
  cy.get(selectors.lastName).clear().type(validUser.lastName)
  cy.get(selectors.email).clear().type(validUser.email)

  selectByLabel('Country code').select(validUser.countryCode)
  cy.get(selectors.phone).clear().type(validUser.phone)

  cy.get(selectors.addressLine1).clear().type(validUser.addressLine1)
  cy.get(selectors.addressLine2).clear().type(validUser.addressLine2)
  cy.get(selectors.state).clear().type(validUser.state)
  cy.get(selectors.postalCode).clear().type(validUser.postalCode)

  selectByLabel('Country').select(validUser.country)
  cy.get(selectors.birthDate).clear().type(validUser.birthDate)
  cy.get(selectors.female).check()
  cy.get(selectors.terms).check()
}

describe('LetCode - formulario de cadastro', () => {
  beforeEach(() => {
    cy.viewport(1366, 768)
    cy.visit(FORM_PAGE)
    cy.contains('h1', 'Form').should('be.visible')
  })

  it('deve preencher e enviar o formulario com dados validos', () => {
    fillValidForm()

    cy.get(selectors.firstName).should('have.value', validUser.firstName)
    cy.get(selectors.lastName).should('have.value', validUser.lastName)
    cy.get(selectors.email).should('have.value', validUser.email)
    cy.get(selectors.phone).should('have.value', validUser.phone)
    cy.get(selectors.female).should('be.checked')
    cy.get(selectors.terms).should('be.checked')

    selectByLabel('Country code').should('have.value', validUser.countryCode)
    selectByLabel('Country').should('have.value', validUser.country)

    cy.get('form').then(($form) => {
      expect($form[0].checkValidity(), 'validade do formulario').to.eq(true)
    })

    cy.get(selectors.submit)
      .should('be.visible')
      .and('be.enabled')
      .click()

    cy.location('pathname').should('eq', '/forms')
  })

  it('deve bloquear envio quando campos obrigatorios estao vazios', () => {
    cy.get('form').then(($form) => {
      expect($form[0].checkValidity(), 'validade do formulario vazio').to.eq(false)
    })

    cy.get('form :invalid')
      .its('length')
      .should('be.greaterThan', 0)
  })

  it('deve marcar email invalido como campo inconsistente', () => {
    cy.get(selectors.firstName).clear().type(validUser.firstName)
    cy.get(selectors.email).clear().type(invalidEmail)

    cy.get(selectors.email)
      .should('have.value', invalidEmail)
      .and('have.attr', 'type', 'email')
      .then(($input) => {
        expect($input[0].checkValidity(), 'validade do email').to.eq(false)
        expect($input[0].validationMessage, 'mensagem nativa').to.not.eq('')
      })
  })
})
