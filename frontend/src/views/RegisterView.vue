<script setup>
import { ref, reactive, computed } from 'vue'
import axios from 'axios'
import MazInput from 'maz-ui/components/MazInput'
import MazBtn from 'maz-ui/components/MazBtn'
import { useToast } from 'vue-toast-notification';
import router from '../router';
import { useVuelidate } from '@vuelidate/core'
import { required, email, minLength, maxLength } from '@vuelidate/validators'
import { vuelidateTranslator } from '../additional/translator';

const MIN_LENGTH = 6
const MAX_LENGTH = 18

const sending = ref(false)
const toast = useToast();

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

const registerAcc = async () => {
    sending.value = true

    const result = await v.value.$validate()
    const pwMatch = passwordMatch(state.password, state.confirmPassword)
 
    if (!result || !pwMath) {
        let errorMessage = '<span class="text-[17px]">Nu poti crea contul deoarece:</span>'
        let totalErrors = 0

        if(v.value.$dirty)
        {
            v.value.$errors.forEach((error, index) => {
                errorMessage += "<br>"
                errorMessage += `${index + 1}. ${vuelidateTranslator(error.$property, error.$message, MIN_LENGTH, MAX_LENGTH)}`
                totalErrors++
            })
        } else totalErrors = 1

        if(!pwMatch)
        {
            errorMessage += `</br>${totalErrors}. Parolele nu corespund!`
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

    let response = await axios.post('http://localhost/loterie/registerAccount.php', {
        email: email.value,
        username: username.value,
        password: password.value
    })
    
    if (response.data == '1') {
        toast.open({
            message: 'Your account have been registered succesfully!<br> Check your email for activation link. Clicking on this notification will redirect you at login page.',
            duration: 10000,
            type: 'success',
            onClick: function () {
                router.push({ path: '/login' })
            }
        })
    }
    else 
    {
        toast.open({
            message: `An error has been encountered!<br> Error: ${response.data}`,
            duration: 5000,
            position: 'bottom-right',
            type: 'error',
        })
    }

    sending.value = false
}

</script>

<template>
    <div class="relative max-w-[400px] mx-auto mt-[150px] flex flex-col gap-[30px] items-center border-2 border-[#000000] px-[40px] py-[50px]">
        <div>
            <h1 class="text-[25px] text-center text-black uppercase font-medium mb-[10px]">Înregistrare</h1>
            <p class="text-center text-black">Va rugam sa folositi o adresa de e-mail valida in asa fel incat sa va putem contacta!</p>
        </div>
        <MazInput v-if="v.email.$error" error label="Adresa de e-mail" class="w-full" no-radius auto-focus v-model="state.email"/>
        <MazInput v-else label="Adresa de e-mail" class="w-full" no-radius auto-focus v-model="state.email"/>
        <MazInput v-if="v.username.$error" error label="Nume de utilizator" class="w-full" no-radius v-model="state.username"/>
        <MazInput v-else label="Nume de utilizator" class="w-full" no-radius v-model="state.username"/>
        <MazInput v-if="v.password.$error" error label="Parola" class="w-full" no-radius type="password" v-model="state.password"/>
        <MazInput v-else label="Parola" class="w-full" no-radius type="password" v-model="state.password"/>
        <MazInput v-if="confirmPasswordError" error label="Confirmare parola" class="w-full" no-radius type="password" v-model="state.confirmPassword"/>
        <MazInput v-else label="Confirmare parola" class="w-full" no-radius type="password" v-model="state.confirmPassword"/>
        <MazBtn v-if="!sending" class="w-full px-0 py-[20px]" color="black" @click="registerAcc">Register</MazBtn>
        <MazBtn v-else class="w-full px-0 py-[20px]" color="black" loading>Register</MazBtn>
    </div>
</template>