<script setup>
import { ref, reactive, computed } from 'vue'
import axios from 'axios'
import MazInput from 'maz-ui/components/MazInput'
import MazBtn from 'maz-ui/components/MazBtn'
import { useToast } from 'vue-toast-notification';
import router from '../router';
import { useVuelidate } from '@vuelidate/core'
import { required, email } from '@vuelidate/validators'

const toast = useToast();
// const account = useAccountStore()


const state = reactive({
    email: '',
    password: ''
})

const rules = {
    email: { required, email },
    password: { required }
}

const v = useVuelidate(rules, state)

function capitalizeFirstLetter(str) {

    // converting first letter to uppercase
    const capitalized = str.charAt(0).toUpperCase() + str.slice(1);

    return capitalized;
}

const registerAcc = async () => {
    const result = await v.value.$validate()

    let errorMessage = '<span class="text-[17px]">You can not log in because:</span>'
    let totalErrors = 0

    v.value.$errors.forEach((error, index) => {
        errorMessage += "<br>"
        errorMessage += `${index}. ${capitalizeFirstLetter(error.$property)}: ${error.$message}`
        totalErrors++
    })

    if(!result)
    {
        toast.open({
            message: `${errorMessage}`,
            type: "error",
            duration: (totalErrors * 4000),
            pauseOnHover: true,
            dismissible: false
        })

        return
    }

    console.log(state.email)

    let {data} = await axios.post('http://localhost/loterie/loginUser.php', {
        email: state.email,
        password: state.password
    }, {
        headers: {
            'Content-Type': 'application/json'
        }
    })

    console.log(data)

    try {
        const userData = JSON.parse(data)
        console.log('Work', userData)
    } catch {
        toast.open({
            message: `An error has been encountered!<br> Error: ${data}`,
            duration: 5000,
            position: 'bottom-right',
            type: 'error',
        })
    }



}



</script>

<template>
    <div
        class="max-w-[400px] bg-[#fdfdfd] mx-auto mt-[200px] flex flex-col gap-[40px] items-center px-[40px] py-[50px] border-[1px] border-black">

        <div class="flex justify-center flex-col items-center gap-[20px]">
            <router-link tag="h1" class="font-bold text-[25px] flex gap-[15px] hover:text-[#000]" to="/">
                <span class="text-white bg-[#000] px-[20px]">CAR</span>
                <span>LOTERRY</span>
            </router-link>
            <p class="text-center text-black">Va rugam sa va folositi datele pe care le-ati introdus pe pagina de inregistrare!</p>
        </div>
        

        <div class="w-full flex flex-col gap-[30px] items-center">
            <MazInput no-radius auto-focus v-if="v.email.$error" error label="Email" class="w-full" v-model="state.email" />
            <MazInput no-radius auto-focus v-else label="Email" class="w-full" v-model="state.email" />
            <MazInput no-radius v-if="v.password.$error" error label="Password" class="w-full" type="password" v-model="state.password" />
            <MazInput no-radius v-else label="Password" class="w-full" type="password" v-model="state.password" />
            <MazBtn class="w-full px-0 py-[20px]" color="black" @click="registerAcc">Register</MazBtn>
            <!-- <button  class="w-full border-[1px] border-black text-[17px] px-[15px] py-[5px] hover:bg-black hover:text-white"  @click="registerAcc">Login</button> -->
        </div>
    </div>
</template>