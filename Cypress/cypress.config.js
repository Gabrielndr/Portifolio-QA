const { defineConfig } = require('cypress')

module.exports = defineConfig({
  e2e: {
    baseUrl: 'https://letcode.in',
    specPattern: 'e2e/**/*.cy.js',
    supportFile: 'support/e2e.js',
    fixturesFolder: 'fixtures',
    screenshotsFolder: 'screenshots',
    videosFolder: 'videos',
    viewportWidth: 1366,
    viewportHeight: 768,
    defaultCommandTimeout: 8000,
    pageLoadTimeout: 60000,
    requestTimeout: 10000,
    responseTimeout: 30000,
    retries: {
      runMode: 1,
      openMode: 0,
    },
    video: true,
    screenshotOnRunFailure: true,
    setupNodeEvents(on, config) {
      return config
    },
  },
})
