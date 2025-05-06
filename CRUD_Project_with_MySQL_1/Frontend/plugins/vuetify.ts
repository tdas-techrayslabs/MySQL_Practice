import 'vuetify/styles'
import { createVuetify } from 'vuetify'
import '@mdi/font/css/materialdesignicons.css' // Ensure you are using css-loader

export default defineNuxtPlugin((app) => {
  const vuetify = createVuetify({
    // ... your configuration
    icons: {
      defaultSet: 'mdi', // This is already the default value - only for display purposes
    },
  })
  app.vueApp.use(vuetify)
})
