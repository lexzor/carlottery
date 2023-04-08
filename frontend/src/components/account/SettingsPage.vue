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
    <h3 class="text-[#000] text-[20px] font-normal">Informațiile contului</h3>
    <p class="text-[14px] text-slate-500">Toate informațiile din secțiunea de mai jos sunt foarte importante pentru contul dvs.</p>
    <div class="mt-3 mb-5 flex xl:flex-row flex-col gap-3 justify-between">
        <div>
            <p class="text-[16px] text-slate-800">Nume de utilizator</p>
            <p class="text-[16px] text-slate-500">{{ account.getUsername() }}</p>
        </div>
        <div>
            <p class="text-[16px] text-slate-800">Nume</p>
            <p class="text-[16px] text-slate-500">Marin</p>
        </div>
        <div>
            <p class="text-[16px] text-slate-800">Prenume</p>
            <p class="text-[16px] text-slate-500">Pavel</p>
        </div>
        <div>
            <p class="text-[16px] text-slate-800">Adresă de e-mail</p>
            <p class="text-[16px] text-slate-500">{{ account.getEmail() }}</p>
        </div>
    </div>
    <h3 class="text-[#000] text-[20px] font-normal">Schimbă parola</h3>
    <p class="text-[14px] text-slate-500">Creeați o nouă parolă care să îndeplinească toate cerințele</p>
    <div class="flex mt-3">
        <MazInput class="w-full" :error="passwordVuelidate.currPw.$error || passwordState.pwMatch" v-model="passwordState.currPw" type="password" no-radius label="Parola actuala" />
    </div>
    <div class="flex mt-3 xl:flex-row flex-col gap-3">
        <MazInput class="w-full" :error="passwordVuelidate.newPw.$error" v-model="passwordState.newPw" type="password" no-radius label="Parola noua" />
        <MazInput class="w-full" :error="passwordVuelidate.confPw.$error" v-model="passwordState.confPw" type="password" no-radius label="Confirmare Parolă" />
    </div>
    <div class="flex mt-3">
        <MazBtn class="w-full" :loading="passwordState.changing == true ? true : false" @click="changePasswordEvent">Schimbă parola</MazBtn>
    </div>
</template>