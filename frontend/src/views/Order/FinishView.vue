<script setup>
import NavBar from '../../components/NavBar.vue';
import MazInput from 'maz-ui/components/MazInput'
import MazSelect from "maz-ui/components/MazSelect"
import MazTextArea from "maz-ui/components/MazTextArea"

import { reactive } from 'vue';
import useVuelidate from '@vuelidate/core';
import { required, email } from '@vuelidate/validators'
import { vuelidateTranslator } from '../../additional/translator';

const countrys = [
    { label: 'Romania', value: 'Romania' },
    { label: 'Franta', value: 'Franta' },
    { label: 'Italia', value: 'Italia' },
    { label: 'Spania', value: 'Spania' },
    { label: 'Irlanda', value: 'Irlanda' },
    { label: 'Germania', value: 'Germania' },
    { label: 'Belgia', value: 'Belgia' },
    { label: 'Austria', value: 'Austria' },
    { label: 'Grecia', value: 'Grecia' },
    { label: 'Regatul unit', value: 'Regatul Unit' },
    { label: 'Republica Moldova', value: 'Republica Moldova' },
    { label: 'Israel', value: 'Israel' },
    { label: 'Ungaria', value: 'Ungaria' },
    { label: 'Olanda', value: 'Olanda' },
    { label: 'Danemarca', value: 'Danemarca' },
    { label: 'Suedia', value: 'Suedia' },
    { label: 'Portugalia', value: 'Portugalia' },
    { label: 'Serbia', value: 'Serbia' },
    { label: 'Irlanda', value: 'Irlanda' },
]

/*
    await axios.post('http://localhost/loterie/makePayment.php', {
        'quantity': ticketNum.value * currentEvent.value.price,
        'event_id': currentEvent.value.id
    }, {
        headers: {
          "Content-Type": "application/json",
        },
    }).catch(err => console.error).then(({data}) => {
        window.location.href = data
    })
*/

const state = reactive({
    firstName: '',
    lastName: '',
    companyName: '',
    country: '',
    address: '',
    secondAddress: '',
    zipCode: '',
    city: '',
    phone: '',
    email: '',
    additionalInformation: '',
})

const rules = {
    firstName: { required },
    lastName: { required },
    companyName: { required },
    country: { required },
    address: { required },
    secondAddress: { required },
    zipCode: { required },
    city: { required },
    phone: { required },
    email: { required, email },
    additionalInformation: { required },
}

const v = useVuelidate(rules, state)

</script>
<template>
        <NavBar />
    <div class="mt-[200px] w-[60%] mx-auto flex flex-col gap-[10px] mb-[200px]">
        <h1 class="uppercase text-center text-[20px] font-bold">Detalii Pentru Facturare</h1>
        <h1>Casutele care sunt notate cu <span class="text-red-600">*</span> sunt obligatorii</h1>
        <div class="flex justify-between gap-[30px] flex-grow-1">
            <MazInput required class="w-full" label="Prenume" no-radius />    
            <MazInput required class="w-full" label="Nume" no-radius />    
        </div>
        <MazInput no-radius label="Nume Companie (Optional)" />
        <MazSelect required label="Tara" no-radius :options="countrys" search max-list-width="full" />
        <MazInput required no-radius label="Nume strada, numar etc." />
        <MazInput no-radius label="Apartament, complex, unitate etc. (optional)" />
        <MazInput required no-radius label="Cod Postal" />
        <MazInput required no-radius label="Oras" />
        <MazInput required no-radius label="Telefon" />
        <MazInput required no-radius label="Adresa email" />
        <h1 class="uppercase text-center text-[20px] font-bold">Informatii Suplimentare</h1>
        <MazTextArea required no-radius label="Note comanda (optional)" placeholder="Note referitoare la comanda ta, de exemplu: anumite note pentru livrare" />
        <h1 class="uppercase text-center text-[20px] font-bold">Comanda Ta</h1>
        <div class="w-full flex flex-col border-[1px] border-b-gray-300">
            <div class="flex justify-between border-b-[1px] border-b-gray-300 p-[20px]">
                <h1 class="font-bold">Produs</h1>
                <h1 class="font-bold">Sub-total</h1>
            </div>
            <div class="flex items-center justify-between border-b-[1px] border-b-gray-300 p-[20px]">
                <div>
                    <h1>Mercedes GLA <span class="font-bold">x 5</span></h1>
                    <h1><span class="font-bold">Raspuns:</span> C220</h1>
                </div>
                <h1>15&euro;</h1>
            </div>
            <div class="flex justify-between border-b-[1px] border-b-gray-300 p-[20px]">
                <h1 class="font-bold">Sub-total</h1>
                <h1 class="font-bold">15&euro;</h1>
            </div>
            <div class="flex justify-between p-[20px]">
                <h1 class="font-bold">Produs</h1>
                <h1 class="font-bold">Sub-total</h1>
            </div>
        </div>
    </div>
</template>