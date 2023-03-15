<script setup>
import { ref, reactive, computed, onUnmounted } from 'vue'
import axios from 'axios'
import MazInput from 'maz-ui/components/MazInput'
import MazBtn from 'maz-ui/components/MazBtn'
import { useToast } from 'vue-toast-notification'
import router from '../router'
import { useVuelidate } from '@vuelidate/core'
import { required, email, minLength, maxLength } from '@vuelidate/validators'
import { vuelidateTranslator } from '../additional/translator'
import { useAccountStore } from '../stores/account'

import NavBar from '../components/NavBar.vue'

const account = useAccountStore()

if(account.isLogged())
{
    router.push({path: '/'})
}

const MIN_LENGTH = 6
const MAX_LENGTH = 18
const REDIRECT_TIME = 10

const sending = ref(false)
const duplicateUser = ref(false)
const duplicateEmail = ref(false)
const toast = useToast();
let redTimeout = null

const state = reactive({
    email: '',
    username: '',
    password: '',
    confirmPassword: '',
    passwordMatch: true
})

const rules = {
    email: { required, email },
    username: {
        required,
        minLength: minLength(MIN_LENGTH),
        maxLength: maxLength(MAX_LENGTH)
    },
    password: {
        required,
        minLength: minLength(MIN_LENGTH),
        maxLength: maxLength(MAX_LENGTH)
    },
    confirmPassword: {
        required,
        minLength: minLength(MIN_LENGTH),
        maxLength: maxLength(MAX_LENGTH),
    }    
}

const v = useVuelidate(rules, state)

function passwordMatch(pw1, pw2)
{   
    if(pw1 === pw2)
    {
        state.passwordMatch = true
        return true
    }

    state.passwordMatch = false
    return false;
}

const confirmPasswordError = computed(() => {
    return (!state.passwordMatch || v.value.confirmPassword.$error) ? true : false
})

const hasEmailErr = computed(() => {
    return duplicateEmail.value
})

const hasUsernameErr = computed(() => {
    return duplicateUser.value
})

onUnmounted(() => {
    if(redTimeout !== null)
    {
        clearTimeout(redTimeout)
    }
})

const registerAcc = async () => {
    sending.value = true

    const result = await v.value.$validate()
    const pwMatch = passwordMatch(state.password, state.confirmPassword)

    if (!result || !pwMatch) {
        let errorMessage = '<span class="text-[17px]">Nu poti crea contul deoarece:</span>'
        let totalErrors = 0

        if(v.value.$dirty)
        {
            v.value.$errors.forEach(error => {
                totalErrors++
                errorMessage += "<br>"
                errorMessage += `${totalErrors}. ${vuelidateTranslator(error.$property, error.$message, MIN_LENGTH, MAX_LENGTH)}`
            })
        }

        if(!pwMatch)
        {
            errorMessage += `</br>${totalErrors + 1}. Parolele nu corespund!`
        }

        toast.open({
            message: `${errorMessage}`,
            type: "error",
            duration: (totalErrors * 6000),
            pauseOnHover: true,
            dismissible: false
        })

        sending.value = false
        return
    } 

    let { data } = await axios.post('http://localhost/loterie/registerAccount.php', {
        email: state.email,
        username: state.username,
        password: state.password
    }, {
        headers: {
            'Content-Type': 'application/json'
        }
    })

    console.log(data)

    if (data == '1') {
        duplicateEmail.value = false
        duplicateUser.value = false

        toast.open({
            message: `Contul a fost crea cu succes!<br>Verifica emailul pentru linkul de activare.<br>Vei fi redirectionat catre pagina de logare in ${REDIRECT_TIME} secunde automat sau apasand pe notificare.`,
            duration: 10000,
            type: 'success',
            onClick: function () {
                router.push({ path: '/login' })
            }
        })

        redTimeout = setTimeout(() => {
            router.push({ path: '/login' })
            clearTimeout(timeout)
        }, REDIRECT_TIME * 1000)
    }
    else 
    {
        let errorMsg = ''

        if (data.indexOf('duplicate'))
        {
            if(data.indexOf('email') != -1)
            {
                errorMsg += 'Acest <b>cont</b> deja exista!'
                duplicateEmail.value = true
            }
            else 
            {
                errorMsg +=' Acest <b>nume de utilizator</b> este deja folosit!'
                duplicateUser.value = true
            }
        }
        else
        {
            errorMsg = data
            duplicateEmail.value = false
            duplicateUser.value = false
        }

        toast.open({
            message: `${errorMsg}`,
            duration: 5000,
            position: 'bottom-right',
            type: 'error',
        })
    }

    sending.value = false
}

</script>

<template>
    <NavBar />
    <div class="relative max-w-[400px] mx-auto mt-[150px] flex flex-col gap-[30px] items-center border-[1px] border-black px-[40px] py-[50px]">
        <div>
            <h1 class="text-[25px] text-center text-black uppercase font-medium mb-[10px]">Înregistrare</h1>
            <p class="text-center text-black">Va rugam sa folositi o adresa de e-mail valida in asa fel incat sa va putem contacta!</p>
        </div>
        <MazInput v-if="hasEmailErr || v.email.$error" error label="Adresa de e-mail" class="w-full" no-radius auto-focus v-model="state.email"/>
        <MazInput v-else label="Adresa de e-mail" class="w-full" no-radius auto-focus v-model="state.email"/>
        <MazInput v-if="hasUsernameErr || v.username.$error" error auto-focus label="Nume de utilizator" class="w-full" no-radius v-model="state.username"/>
        <MazInput v-else label="Nume de utilizator" auto-focus class="w-full" no-radius v-model="state.username"/>
        <MazInput v-if="v.password.$error" auto-focus error label="Parola" class="w-full" no-radius type="password" v-model="state.password"/>
        <MazInput v-else label="Parola" auto-focus class="w-full" no-radius type="password" v-model="state.password"/>
        <MazInput v-if="confirmPasswordError" auto-focus error label="Confirmare parola" class="w-full" no-radius type="password" v-model="state.confirmPassword"/>
        <MazInput v-else label="Confirmare parola" auto-focus class="w-full" no-radius type="password" v-model="state.confirmPassword"/>
        <MazBtn v-if="!sending" class="w-full px-0 py-[20px]" color="black" @click="registerAcc">Register</MazBtn>
        <MazBtn v-else class="w-full px-0 py-[20px]" color="black" loading>Register</MazBtn>
    </div>
</template>