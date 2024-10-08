<script setup>
import { ref, reactive, computed, onUnmounted } from "vue"
import axios from "axios"
import MazInput from "maz-ui/components/MazInput"
import MazBtn from "maz-ui/components/MazBtn"
import { useToast } from "vue-toast-notification"
import router from "../router"
import { useVuelidate } from "@vuelidate/core"
import { required, email, minLength, maxLength } from "@vuelidate/validators"
import { vuelidateTranslator } from "../additional/translator"
import NavBar from "../components/NavBar.vue"
import Footer from "../components/Footer.vue"
import MazCheckbox from 'maz-ui/components/MazCheckbox'

const BASE_URL = import.meta.env.VITE_SERVER_BASE_URL

const MIN_LENGTH = 6
const MAX_LENGTH = 18
const REDIRECT_TIME = 10

const sending = ref(false)
const duplicateUser = ref(false)
const duplicateEmail = ref(false)
const toast = useToast()
let redTimeout = null

const state = reactive({
  email: "",
  username: "",
  password: "",
  confirmPassword: "",
  passwordMatch: true,
  terms: false
})

const rules = {
  email: { required, email },
  username: {
    required,
    minLength: minLength(MIN_LENGTH),
    maxLength: maxLength(MAX_LENGTH),
  },
  password: {
    required,
    minLength: minLength(MIN_LENGTH),
    maxLength: maxLength(MAX_LENGTH),
  },
  confirmPassword: {
    required,
    minLength: minLength(MIN_LENGTH),
    maxLength: maxLength(MAX_LENGTH),
  },
}

const v = useVuelidate(rules, state)

function passwordMatch(pw1, pw2) {
  if (pw1 === pw2) {
    state.passwordMatch = true
    return true
  }

  state.passwordMatch = false
  return false
}

const confirmPasswordError = computed(() => {
  return !state.passwordMatch || v.value.confirmPassword.$error ? true : false
})

const hasEmailErr = computed(() => {
  return duplicateEmail.value
})

const hasUsernameErr = computed(() => {
  return duplicateUser.value
})

onUnmounted(() => {
  if (redTimeout !== null) {
    clearTimeout(redTimeout)
  }
})

const registerAcc = async () => {
  sending.value = true

  const result = await v.value.$validate()
  const pwMatch = passwordMatch(state.password, state.confirmPassword)

  if (!result || !pwMatch) {
    let errorMessage =
      '<span class="text-[17px]">Nu poti crea contul deoarece:</span>'
    let totalErrors = 0

    if (v.value.$dirty) {
      v.value.$errors.forEach((error) => {
        totalErrors++
        errorMessage += "<br>"
        errorMessage += `${totalErrors}. ${vuelidateTranslator(
          error.$property,
          error.$message, {
          "minL": MIN_LENGTH,
          "maxL": MAX_LENGTH
        }
        )}`
      })
    }

    if (!pwMatch) {
      errorMessage += `</br>${++totalErrors}. Parolele nu corespund!`
    }

    if (!state.terms) {
      errorMessage += `</br>${++totalErrors}. Trebuie acceptați <b>Termenii și Condițiile</b>`
    }

    toast.open({
      message: `${errorMessage}`,
      type: "error",
      duration: totalErrors * 6000,
      pauseOnHover: true,
      dismissible: false,
    })

    sending.value = false
    return
  }

  let { data } = await axios.post(
    BASE_URL + "registerAccount.php",
    {
      email: state.email,
      username: state.username,
      password: state.password,
    },
    {
      headers: {
        "Content-Type": "application/json",
      },
    }
  )

  if (data == "1") {
    duplicateEmail.value = false
    duplicateUser.value = false

    toast.open({
      message: `Contul a fost crea cu succes!<br>Verifica e-mailul pentru linkul de activare.<br>Vei fi redirectionat catre pagina de logare in ${REDIRECT_TIME} secunde automat sau apasand pe notificare.`,
      duration: 10000,
      type: "success",
      onClick: function () {
        router.push({ path: "/login" })
      },
    })

    redTimeout = setTimeout(() => {
      router.push({ path: "/login" })
      clearTimeout(timeout)
    }, REDIRECT_TIME * 1000)
  } else {
    let errorMsg = ""

    console.log(data)

    if (data.indexOf("duplicate")) {
      if (data.indexOf("email") != -1) {
        errorMsg += "Acest <b>cont</b> deja exista!"
        duplicateEmail.value = true
      } else {
        errorMsg += " Acest <b>nume de utilizator</b> este deja folosit!"
        duplicateUser.value = true
      }
    } else {
      errorMsg = data
      duplicateEmail.value = false
      duplicateUser.value = false
    }

    toast.open({
      message: `${errorMsg}`,
      duration: 5000,
      position: "bottom-right",
      type: "error",
    })
  }

  sending.value = false
}
</script>

<template>
  <NavBar />
  <div class="xl:px-[0px] px-[25px]">
    <div
      class="relative max-w-[400px] mx-auto my-[60px] flex flex-col gap-[30px] items-center border-[1px] border-black px-[40px] py-[50px]">
      <div>
        <h1 class="text-[25px] text-center text-black uppercase font-medium mb-[10px]">
          Înregistrare
        </h1>
        <p class="text-center text-black">
          Vă rugăm să folosiți o adresă de e-mail validă în așa fel încat să vă
          putem contacta
        </p>
      </div>
      <MazInput :error="hasEmailErr || v.email.$error" label="Adresa de e-mail" class="w-full" no-radius
        v-model="state.email" />
      <MazInput :error="hasUsernameErr || v.username.$error" label="Nume de utilizator" class="w-full" no-radius
        v-model="state.username" />
      <MazInput :error="v.password.$error" label="Parola" class="w-full" no-radius type="password"
        v-model="state.password" />
      <MazInput :error="confirmPasswordError" label="Confirmare parola" class="w-full" no-radius type="password"
        v-model="state.confirmPassword" />
      <div class="flex items-center self-start mt-[16px]">
        <input id="link-checkbox" type="checkbox" v-model="state.terms"
          class="w-4 h-4 text-black bg-gray-100 border-gray-300 rounded-sm focus:ring-gray-500 dark:focus:ring-gray-600 dark:ring-offset-gray-800 focus:ring-1 dark:bg-gray-700 dark:border-gray-600">
        <label for="link-checkbox" class="ml-2 text-sm text-gray-600">Sunt de acord cu <router-link tag="span"
            to="/termeni-si-conditii" class="underline text-blue-400">Termenii si Conditiile</router-link>.</label>
      </div>
      <MazBtn v-if="!sending" class="w-full px-0 py-[20px]" color="black" @click="registerAcc">Register</MazBtn>
      <MazBtn v-else class="w-full px-0 py-[20px]" color="black" loading>Register</MazBtn>
    </div>
  </div>
  <Footer />
</template>
