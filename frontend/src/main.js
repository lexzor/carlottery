import { createApp } from "vue"
import { createPinia } from "pinia"

import App from "./App.vue"
import router from "./router"

import { library } from "@fortawesome/fontawesome-svg-core"
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome"
import { faUser } from "@fortawesome/free-solid-svg-icons"

import "vue-toast-notification/dist/theme-default.css"
import "maz-ui/css/main.css"
import "./assets/main.css"

const app = createApp(App)
const pinia = createPinia()

library.add(faUser)

app.use(pinia)
app.use(router)
app.component("font-awesome-icon", FontAwesomeIcon)
app.mount("#app")
