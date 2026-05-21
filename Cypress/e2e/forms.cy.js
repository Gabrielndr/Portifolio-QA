const selectors = {
  form: 'form[action="submitted-form.html"]',
  text: '#my-text-id',
  password: 'input[name="my-password"]',
  textarea: 'textarea[name="my-textarea"]',
  select: 'select[name="my-select"]',
  datalist: 'input[name="my-datalist"]',
  checkedCheckbox: '#my-check-1',
  defaultCheckbox: '#my-check-2',
  checkedRadio: '#my-radio-1',
  defaultRadio: '#my-radio-2',
  date: 'input[name="my-date"]',
  range: 'input[name="my-range"]',
  submit: 'button[type="submit"]',
}

const validUser = {
  name: 'Gabriel Andrade',
  password: 'senha-segura',
  notes: 'Teste automatizado com Cypress',
  city: 'Seattle',
  date: '05/21/2026',
  range: '8',
}

const fillValidForm = () => {
  cy.get(selectors.text).clear().type(validUser.name)
  cy.get(selectors.password).clear().type(validUser.password, { log: false })
  cy.get(selectors.textarea).clear().type(validUser.notes)
  cy.get(selectors.select).select('Two')
  cy.get(selectors.datalist).clear().type(validUser.city)
  cy.get(selectors.defaultCheckbox).check()
  cy.get(selectors.defaultRadio).check()
  cy.get(selectors.date).clear().type(validUser.date).blur()
  cy.get(selectors.range)
    .invoke('val', validUser.range)
    .trigger('input', { force: true })
    .trigger('change', { force: true })
}

describe('Selenium Web Form - formulario', () => {
  beforeEach(() => {
    cy.visitSeleniumPage('web-form.html')
    cy.contains('h1', 'Web form').should('be.visible')
  })

  it('deve preencher e enviar o formulario com dados validos', () => {
    fillValidForm()

    cy.get(selectors.text).should('have.value', validUser.name)
    cy.get(selectors.password).should('have.value', validUser.password)
    cy.get(selectors.textarea).should('have.value', validUser.notes)
    cy.get(selectors.select).should('have.value', '2')
    cy.get(selectors.datalist).should('have.value', validUser.city)
    cy.get(selectors.defaultCheckbox).should('be.checked')
    cy.get(selectors.defaultRadio).should('be.checked')
    cy.get(selectors.date).should('have.value', validUser.date)
    cy.get(selectors.range).should('have.value', validUser.range)

    cy.get(selectors.submit).click()

    cy.contains('h1', 'Form submitted').should('be.visible')
    cy.get('#message').should('have.text', 'Received!')
  })

  it('deve enviar os campos preenchidos na query string', () => {
    fillValidForm()
    cy.get(selectors.submit).click()

    cy.location('search').then((search) => {
      const params = new URLSearchParams(search)

      expect(params.get('my-text')).to.eq(validUser.name)
      expect(params.get('my-password')).to.eq(validUser.password)
      expect(params.get('my-textarea')).to.eq(validUser.notes)
      expect(params.get('my-select')).to.eq('2')
      expect(params.get('my-datalist')).to.eq(validUser.city)
      expect(params.get('my-date')).to.eq(validUser.date)
      expect(params.get('my-range')).to.eq(validUser.range)
    })
  })

  it('deve manter metadados essenciais do formulario', () => {
    cy.get(selectors.form)
      .should('have.attr', 'method', 'get')
      .and('have.attr', 'action')
      .and('include', 'submitted-form.html')

    cy.get(selectors.checkedCheckbox).should('be.checked')
    cy.get(selectors.checkedRadio).should('be.checked')
  })
})
