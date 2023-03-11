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
    <div class="relative max-w-[400px] mx-auto mt-[200px] flex flex-col gap-[30px] items-center bg-slate-200 px-[40px] py-[50px] pt-[100px] rounded-lg shadow-lg">
        <h1 class="absolute top-[30px] text-[25px] text-orange-600">Register an account!</h1>
        <MazInput label="Email" class="w-full" v-model="email"/>
        <MazInput label="Username" class="w-full" v-model="username"/>
        <MazInput label="Password" class="w-full" type="password" v-model="password"/>
        <MazBtn v-if="!sending" class="max-w-[120px]" @click="registerAcc">Register</MazBtn>
        <MazBtn v-else class="max-w-[120px]" loading>Register</MazBtn>
    </div>
</template>