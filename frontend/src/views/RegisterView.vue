<script setup>
import { ref } from 'vue'
import axios from 'axios'
import MazInput from 'maz-ui/components/MazInput'
import MazBtn from 'maz-ui/components/MazBtn'
import { useToast } from 'vue-toast-notification';
import router from '../router';

const email = ref('')
const username = ref('')
const password = ref('')
const repassword = ref('')
const sending = ref(false)

const toast = useToast();

const registerAcc = async () => {
    sending.value = true
    let response = await axios.post('http://localhost/loterie/registerAccount.php', {
        email: email.value,
        username: username.value,
        password: password.value
    })

    console.log(response.data)
    
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
        <MazInput label="Adresa de e-mail" class="w-full" no-radius auto-focus="true" v-model="email"/>
        <MazInput label="Nume de utilizator" class="w-full" no-radius v-model="username"/>
        <MazInput label="Parola" class="w-full" no-radius type="password" v-model="password"/>
        <MazInput label="Confirmare parola" class="w-full" no-radius type="password" v-model="repassword"/>
        <MazBtn v-if="!sending" class="w-full px-0 py-[20px]" color="black" @click="registerAcc">Register</MazBtn>
        <MazBtn v-else class="w-full px-0 py-[20px]" color="black" loading>Register</MazBtn>
    </div>
</template>