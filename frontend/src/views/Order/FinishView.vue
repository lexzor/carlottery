<script setup>
import NavBar from '../../components/NavBar.vue';
import MazInput from 'maz-ui/components/MazInput'
import MazSelect from "maz-ui/components/MazSelect"
import MazTextArea from "maz-ui/components/MazTextArea"
import MazBtn from "maz-ui/components/MazBtn"
import Footer from '../../components/Footer.vue';

import { reactive, ref } from 'vue';
import useVuelidate from '@vuelidate/core';
import { required, email } from '@vuelidate/validators'
import { vuelidateTranslator } from '../../additional/translator';
import { getEvents } from '../../additional/axiosPosts'
import { useAccountStore } from '../../stores/account';

import {loadStripe} from '@stripe/stripe-js';

import axios from 'axios'

const events = ref([])
const account = useAccountStore()

const retrieveEvents = async () => {
    const allEvents = await getEvents()
    
    events.value = allEvents.filter(ev => {
        return account.getStore().some(storeEvent => {
            if(ev.id == storeEvent.id) {
                ev['tickets'] = storeEvent.tickets
                return true 
            }
        })
    })

    console.log(allEvents)
}

retrieveEvents()

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
]

const STRIPE = 0
const PAYPAL = 1

const PAYMENT_METHODS = [
    {
        id: STRIPE,
        name: 'Stripe'
    },
    {
        id: PAYPAL, 
        name: 'PayPal'
    }
]

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
    paymentMethod: PAYMENT_METHODS[STRIPE].name
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

const calculateTotal = () => {
    let totalPrice = 0
    events.value.forEach(ev => {
        totalPrice += ev.price * ev.tickets
    })

    return totalPrice
}

const stripeLoad = () => {
    if (!window.stripePromise) {
        window.stripePromise = loadStripe('pk_test_51Mnpq4LJ9kTHN7J8Kj7FGMIsoMcKWvMFHPN1gkhZnf6JRuiemvMtPWCeg1cNdflysbWoqHgdlKDX0GBXNQDszyES00pmUyGEqk');
    }
    return window.stripePromise;
}

const makePaymentStripe = async () => {
    const eventsIds = []
    const cartEvents = await getEvents()
    events.value.forEach((event) => {
        const eventDict = {
            'id': event.id,
            'quantity': event.tickets
        }
        eventsIds.push(eventDict)
    })
    
    let cart = []

    events.value.forEach((event) => {
        let cartData = {
            "id": event.id,
            "title": event.title,
            "quantity": event.tickets,
            "price": event.price * event.tickets
        }
        cart.push(cartData)
    })

    await axios.post('http://localhost/loterie/makePayment.php', {
        'events': eventsIds,
        'metadata': {
            customerEmail: state.email,
            customerPhoneNumber: state.phone,
            customerDetails: {
                firstName: state.firstName,
                lastName: state.lastName,
                companyName: state.companyName,
                country: state.country,
                streetName: state.address,
                houseNumber: state.secondAddress,
                postCode: state.zipCode,
                city: state.city,
                notes: state.additionalInformation,
                products: cart,
            }
        }
    }, {
        headers: {
          "Content-Type": "application/json",
        },
    }).catch(err => console.error).then(async ({data}) => {
        // console.log(data)
        const stripe = await stripeLoad()

        stripe.redirectToCheckout({
            sessionId: data,
        })
    })

    
}

</script>

<template>
        <NavBar />
    <div class="mt-[200px] w-[60%] mx-auto flex flex-col gap-[10px] mb-[200px]">
        <h1 class="uppercase text-center text-[20px] font-bold">Detalii Pentru Facturare</h1>
        <h1>Casutele care sunt notate cu <span class="text-red-600">*</span> sunt obligatorii</h1>
        <div class="flex justify-between gap-[30px] flex-grow-1">
            <MazInput required class="w-full" v-model="state.firstName" label="Prenume" no-radius />    
            <MazInput required class="w-full" v-model="state.lastName" label="Nume" no-radius />    
        </div>
        <MazInput no-radius v-model="state.companyName" label="Nume Companie (Optional)" />
        <MazSelect required v-model="state.country" label="Tara" no-radius :options="countrys" search />
        <MazInput required v-model="state.address" no-radius label="Nume strada, numar etc." />
        <MazInput no-radius v-model="state.secondAddress" label="Apartament, complex, unitate etc. (optional)" />
        <MazInput required v-model="state.zipCode" no-radius label="Cod Postal" />
        <MazInput required v-model="state.city" no-radius label="Oras" />
        <MazInput required v-model="state.phone" no-radius label="Telefon" />
        <MazInput required v-model="state.email" no-radius label="Adresa email" />
        <h1 class="uppercase text-center text-[20px] font-bold">Informatii Suplimentare</h1>
        <MazTextArea required v-model="state.additionalInformation" no-radius label="Note comanda (optional)" placeholder="Note referitoare la comanda ta, de exemplu: anumite note pentru livrare" />
        <h1 class="uppercase text-center text-[20px] font-bold">Comanda Ta</h1>
        <div class="w-full flex flex-col border-[1px] border-b-gray-300">
            <div class="flex justify-between border-b-[1px] border-b-gray-300 p-[20px]">
                <h1 class="font-bold">Produs</h1>
                <h1 class="font-bold">Sub-total</h1>
            </div>
            <div class="flex flex-col gap-[20px] items-center justify-between border-b-[1px] border-b-gray-300 p-[20px]">
                <div v-for="event in events" :key="event.id" class="flex items-center justify-between w-full">
                    <div class="py-[10px]">
                        <div class="flex gap-[20px] items-center">
                        <div class="w-[100px] h-[50px] bg-center bg-cover bg-no-repeat" :style="`background-image: url('http://localhost/loterie/${JSON.parse(event.images)[0]}')`"></div>
                        <h1>{{ event.title }} <span class="font-bold">x {{ event.tickets }}</span></h1>
                        </div>
                    </div>
                    <h1>{{ event.tickets * event.price }}&euro;</h1>
                </div>
            </div>
            <div class="flex justify-between border-b-gray-300 p-[20px]">
                <h1 class="font-bold">Total</h1>
                <h1 class="font-bold">{{ calculateTotal() }}&euro;</h1>
            </div>
        </div>

        <div class="">
            <h1 class="uppercase text-center text-[20px] font-bold">Alege metoda de plata</h1>
            <div class="flex gap-[30px]">
                <div v-for="(paymentMethod, index) in PAYMENT_METHODS " :key="paymentMethod.id" class="flex gap-[5px] items-center justify-start">
                    <input @input="selectedPayment" v-model="state.paymentMethod" :value="paymentMethod.name" type="radio" name="pMethod" :id="`pm${paymentMethod.id}`">
                    <label :for="paymentMethod.name">{{ paymentMethod.name }}</label>
                </div>
            </div>
            <div v-if="state.paymentMethod === PAYMENT_METHODS[STRIPE].name" class="mt-[50px]">
                <h1 class="text-[17px]">Plateste prin <b>Stripe</b> folosind<span class="font-bold"> cardul de credit</span>.</h1>
                <h2 class="my-[5px] text-[#585858]">Pentru a asigura faptul ca faci plata printr-o metode securizata vei fi redirecitonat catre pagina oficiala Stripe.</h2>
                <MazBtn
                    class="w-full px-0 py-[20px] mt-3"
                    color="black"
                    @click="makePaymentStripe"
                    >Continua</MazBtn
                >
            </div>
        </div>

    </div>
    <Footer />
</template>