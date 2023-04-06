<script setup>
import MazInput from 'maz-ui/components/MazInput'
import MazBtn from 'maz-ui/components/MazBtn'
import { reactive } from 'vue';
import { vuelidateTranslator } from '../../additional/translator';
import { useVuelidate } from "@vuelidate/core"
import { required, minLength } from "@vuelidate/validators"
import { useToast } from 'vue-toast-notification';
import axios from 'axios';
import { useAccountStore } from '../../stores/account';

const PW_MIN_LENGTH = 6

const toast = useToast()
const account = useAccountStore()

const passwordState = reactive({
    currPw: '',
    newPw: '',
    confPw: '',
    changing: false,
    pwMatch: false
})


const passwordRules = {
    currPw: { required, minLength: minLength(PW_MIN_LENGTH) },
    newPw: { required, minLength: minLength(PW_MIN_LENGTH) },
    confPw: { required, minLength: minLength(PW_MIN_LENGTH) }
}

const passwordVuelidate = useVuelidate(passwordRules, passwordState)


const changePasswordEvent = async () => {
    passwordState.changing = true
    const result = await passwordVuelidate.value.$validate()
    
    if(!result) {        
        let errorMessage =
            '<span class="text-[17px]">Nu te poti schimba parola deoarece:</span>'
        let totalErrors = 0

        passwordVuelidate.value.$errors.forEach((error) => {
            totalErrors++
            errorMessage += "<br>"
            errorMessage += `${totalErrors}. ${vuelidateTranslator(
                error.$property,
                error.$message,
                {
                    minL: PW_MIN_LENGTH
                }
            )}`
        })

        toast.open({
            message: `${errorMessage}`,
            type: "error",
            duration: totalErrors * 6000,
            pauseOnHover: true,
            dismissible: false,
        })

        passwordState.changing = false
        return 
    }

    if (passwordState.currPw !== account.getPassword()) {
        passwordState.pwMatch = true;

        toast.open({
            message: '<span class="text-[17px]">Nu te poti schimba parola deoarece:</span><br>1. Parola actuala este gresita!',
            type: "error",
            duration: 5000,
            pauseOnHover: true,
            dismissible: false,
        })
        passwordState.changing = false
        return
    }


    // await axios.post("http://localhost/loterie/changePassword.php", {
    //     id: account.getId(),
        
    // })
}

</script>

<template>
    <div class="flex flex-col items-center gap-[20px]">
        <MazInput :error="passwordVuelidate.currPw.$error || passwordState.pwMatch" v-model="passwordState.currPw" type="password" required label="Parola actuala" />
        <MazInput :error="passwordVuelidate.newPw.$error" v-model="passwordState.newPw" type="password" required label="Parola noua" />
        <MazInput :error="passwordVuelidate.confPw.$error" v-model="passwordState.confPw" type="password" required label="Confirmare Parola" />
        <MazBtn :loading="passwordState.changing == true ? true : false" @click="changePasswordEvent">Schimba parola</MazBtn>
    </div>
</template>