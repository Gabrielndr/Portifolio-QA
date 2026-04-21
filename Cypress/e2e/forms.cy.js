describe('Formulário de cadastro — LetCode', () => {
    beforeEach(() => {
        cy.viewport(1920, 1080);
        cy.visit('https://letcode.in/forms');
    });

    it('preenche e envia o formulário com dados válidos', () => {
        // Dados do usuário
        cy.get('#firstname').clear().type('Gabriel');
        cy.get('#lasttname').clear().type('da Silva Andrade');
        cy.get('#email').clear().type('gabriel.2001.2308@gmail.com');

        // Seleção de país / telefone
        cy.get(':nth-child(2) > :nth-child(2) > .field > .control > .select > select')
            .select('55');   // código do país
        cy.get('#Phno').clear().type('11 942528073');

        // Endereço
        cy.get('#Addl1').clear().type('Rua bala mineira');
        cy.get('#Addl2').clear().type('Rua das violetass');
        cy.get('#state').clear().type('São Paulo');
        cy.get('#postalcode').clear().type('03554-150');

        // País de residência
        cy.get(':nth-child(5) > :nth-child(2) > .field > .control > .select > select')
            .select('Brazil');

        // Data
        cy.get('#Date').clear().type('2021-08-23');

        // Gênero e checkbox
        cy.get('#female').click();
        cy.get('.checkbox > input').click();

        // Submeter
        cy.get('.control > .button').click();


        cy.url().should('include', '/forms');

    });
});