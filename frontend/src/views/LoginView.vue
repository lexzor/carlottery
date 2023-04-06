<script setup>
import { ref, reactive } from "vue"
import axios from "axios"
import MazInput from "maz-ui/components/MazInput"
import MazBtn from "maz-ui/components/MazBtn"
import { useToast } from "vue-toast-notification"
import { useVuelidate } from "@vuelidate/core"
import { required, email } from "@vuelidate/validators"
import { vuelidateTranslator } from "../additional/translator"
import { useAccountStore } from "../stores/account"
import router from "../router"
import NavBar from "../components/NavBar.vue"
import MazCheckbox from 'maz-ui/components/MazCheckbox'

const account = useAccountStore()

if (account.isLogged()) {
  router.push({ path: "/" })
}

const toast = useToast()
const sending = ref(false)

const state = reactive({
  email: "super.alexx@yahoo.com",
  password: "parolamea",
  remember: false
})

const rules = {
  email: { required, email },
  password: { required },
}

const v = useVuelidate(rules, state)

const loginAcc = async () => {
  const result = await v.value.$validate()
  sending.value = true

  if (!result) {
    let errorMessage =
      '<span class="text-[17px]">Nu te poti loga deoarece:</span>'
    let totalErrors = 0

    v.value.$errors.forEach((error) => {
      totalErrors++
      errorMessage += "<br>"
      errorMessage += `${totalErrors}. ${vuelidateTranslator(
        error.$property,
        error.$message
      )}`
    })

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

    await axios.post(
    "http://localhost/loterie/authUser.php",
    {
      email: state.email,
      password: state.password,
    },
  ).catch(err => console.error).then(({data}) => {
    if (typeof data !== "object" || data === null) {
      toast.open({
        message: "Datele introduse sunt incorecte",
        duration: 5000,
        position: "bottom-right",
        type: "error",
      })
    } else {
      account.loginAcc(data, state.remember)
      router.push({ path: "/" })
      account.authUser
    }
  })

  sending.value = false
}
</script>

<template>
  <NavBar />
  <div
    class="max-w-[400px] bg-[#fdfdfd] mx-auto mt-[200px] flex flex-col gap-[40px] items-center px-[40px] py-[50px] border-[1px] border-black"
  >
    <div class="flex justify-center flex-col items-center">
      <h1
        class="text-[25px] text-center text-black uppercase font-medium mb-[10px]"
      >
        Logare
      </h1>
      <p class="text-center text-black">
        Va rugam sa va folositi datele pe care le-ati introdus pe pagina de
        inregistrare!
      </p>
    </div>

    <div class="w-full flex flex-col gap-[30px] items-center">
      <MazInput
        no-radius
        :error="v.email.$error"
        label="Email"
        class="w-full"
        v-model="state.email"
      />
      <MazInput
        no-radius
        :error="v.password.$error"
        error
        label="Password"
        class="w-full"
        type="password"
        v-model="state.password"
      />
      
      <MazCheckbox v-model="state.remember" class="justify-self-start">Tine-ma minte</MazCheckbox>
      
      <MazBtn
        :loading="sending"
        class="w-full px-0 py-[20px]"
        color="black"
        @click="loginAcc"
        >Login</MazBtn
      >
    </div>
  </div>
</template>
