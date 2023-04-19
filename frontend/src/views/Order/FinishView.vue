<script setup>
import NavBar from '../../components/NavBar.vue';
import MazInput from 'maz-ui/components/MazInput'
import MazSelect from "maz-ui/components/MazSelect"
// import MazTextArea from "maz-ui/components/MazTextArea"
import MazBtn from "maz-ui/components/MazBtn"
import MazPhoneNumberInput from "maz-ui/components/MazPhoneNumberInput"
import Footer from '../../components/Footer.vue';
import { useToast } from 'vue-toast-notification';
import { reactive, ref } from 'vue';
import useVuelidate from '@vuelidate/core';
import { required, email } from '@vuelidate/validators'
import { vuelidateTranslator } from '../../additional/translator';
import { getEvents } from '../../additional/axiosPosts'
import { useAccountStore } from '../../stores/account';
import { loadStripe } from '@stripe/stripe-js';
import axios from 'axios'

const BASE_URL = import.meta.env.VITE_SERVER_BASE_URL

const events = ref([])
const account = useAccountStore()
const toast = useToast()

const retrieveEvents = async () => {
    const allEvents = await getEvents()

    events.value = allEvents.filter(ev => {
        return account.getStore().some(storeEvent => {
            if (ev.id == storeEvent.id) {
                ev['tickets'] = storeEvent.tickets
                ev['answer'] = storeEvent.answer
                return true
            }
        })
    })
}

retrieveEvents()

let countries = [
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

countries.sort((a, b) => {
    if (a.label === "Romania") {
        return -1;
    }
    if (b.label === "Romania") {
        return 1;
    }
    if (a.label < b.label) {
        return -1;
    }
    if (a.label > b.label) {
        return 1;
    }
    return 0;
});

console.log(countries)

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
    country: { required },
    address: { required },
    zipCode: { required },
    city: { required },
    phone: { required },
    email: { required, email },
}

const v = useVuelidate(rules, state)

const calculateTotal = () => {
    let totalPrice = 0
    events.value.forEach(ev => {
        totalPrice += ev.price * ev.tickets
    })
    return parseFloat(totalPrice.toFixed(2))
}

let stripeLoading = ref(false)

const stripeLoad = () => {
    if (!window.stripePromise) {
        window.stripePromise = loadStripe('pk_test_51Mnpq4LJ9kTHN7J8Kj7FGMIsoMcKWvMFHPN1gkhZnf6JRuiemvMtPWCeg1cNdflysbWoqHgdlKDX0GBXNQDszyES00pmUyGEqk');
    }
    return window.stripePromise;
}

const makePaymentStripe = async () => {
    const result = await validateForm()

    if (!result) {
        stripeLoading.value = false
        return
    }

    stripeLoading.value = true
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

    await axios.post(BASE_URL + 'makePayment.php', {
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
    }).catch(err => console.error).then(async ({ data }) => {
        const stripe = await stripeLoad()

        stripe.redirectToCheckout({
            sessionId: data,
        })
    })
}

const validateForm = async () => {
    const result = await v.value.$validate()

    if (!result) {
        let errorMessage =
            '<span class="text-[17px]">Nu poti finaliza plata deoarece:</span>'
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
    }

    return result
}

</script>

<template>
    <NavBar />
    <div class="mx-auto container mt-[80px] px-0">
        <div class="xl:px-[45px] px-[25px]">
            <div class="bg-white shadow rounded flex justify-center xl:p-10 p-4">
                <div class="flex flex-col xl:flex-row">
                    <div
                        class="flex flex-col gap-4 border-b-2 xl:border-b-0 border-r-0 xl:border-r-2 border-gray-400 border-dashed pb-[21px] xl:pr-[21px] mb-[21px] xl:mr-[21px]">
                        <h1 class="uppercase text-[20px] font-bold">Detalii Pentru Facturare</h1>
                        <h1 class="text-[16px]">Casutele care sunt notate cu <span class="text-red-600">*</span> sunt obligatorii.</h1>
                        <div class="flex justify-between relative gap-[30px] flex-grow-1">
                            <MazInput :error="v.firstName.$error" required class="w-full" v-model="state.firstName"
                                label="Prenume" no-radius />
                            <MazInput :error="v.lastName.$error" required class="w-full" v-model="state.lastName"
                                label="Nume" no-radius />
                        </div>
                        <MazInput no-radius v-model="state.companyName" label="Nume Companie (Optional)" />
                        <MazSelect :error="v.country.$error" required v-model="state.country" label="Tara" no-radius
                            :options="countries" search />
                        <MazInput :error="v.address.$error" required v-model="state.address" no-radius
                            label="Nume strada, numar etc." />
                        <MazInput no-radius v-model="state.secondAddress"
                            label="Apartament, complex, unitate etc. (optional)" />
                        <MazInput :error="v.zipCode.$error" required v-model="state.zipCode" no-radius label="Cod Postal" />
                        <MazInput :error="v.city.$error" required v-model="state.city" no-radius label="Oras" />
                        <MazPhoneNumberInput :error="v.phone.$error"
                            :preferred-countries="['RO', 'FR', 'BE', 'DE', 'US', 'GB']" required v-model="state.phone"
                            no-radius label="Telefon" />
                        <MazInput :error="v.email.$error" required v-model="state.email" no-radius label="Adresa email" />
                        <h1 class="uppercase text-[20px] font-bold">Informatii Suplimentare</h1>
                        <textarea v-model="state.additionalInformation" placeholder="Note comanda (optional)"></textarea>
                    </div>
                    <div>
                        <h1 class="uppercase text-[20px] font-bold mb-4">Comanda Ta</h1>
                        <div class="w-full flex flex-col border-[1px] border-b-gray-300">
                            <div class="flex justify-between border-b-[1px] border-b-gray-300 p-[20px]">
                                <h1 class="font-bold text-[16px]">Produs</h1>
                                <h1 class="font-bold text-[16px]">Sub-total</h1>
                            </div>
                            <div
                                class="flex flex-col gap-[20px] items-center justify-between border-b-[1px] border-b-gray-300 p-[20px]">
                                <div v-for="event in events" :key="event.id"
                                    class="flex items-center justify-between w-full">
                                    <div class="py-[10px]">
                                        <div class="flex gap-[20px] items-center">
                                            <div class="w-[100px] h-[50px] bg-center bg-cover bg-no-repeat rounded-lg"
                                                :style="`background-image: url('${BASE_URL + JSON.parse(event.images)[0]}')`">
                                            </div>
                                            <div class="flex flex-col gap-[5px]">
                                                <h1 class="text-[16px]">
                                                    <span class="font-bold text-[16px]">Nume: </span>

                                                    {{ event.title }}

                                                    <span class="font-bold text-[16px]">x {{
                                                        event.tickets }}
                                                    </span>
                                                </h1>
                                                <h1 class="text-[16px]">
                                                    <span class="font-bold">Raspuns:</span>
                                                    {{ event.answer }}
                                                </h1>
                                            </div>
                                        </div>
                                    </div>
                                    <h1 class="text-[16px]">{{ parseFloat((event.tickets * event.price).toFixed(2)) }}&euro;</h1>
                                </div>
                            </div>
                            <div class="flex justify-between border-b-gray-300 p-[20px]">
                                <h1 class="font-bold text-[16px]">Total</h1>
                                <h1 class="font-bold text-[16px]">{{ calculateTotal() }}&euro;</h1>
                            </div>
                        </div>

                        <div class="mt-10">
                            <h1 class="uppercase text-[20px] font-bold mb-4">Alege metodă de plată</h1>
                            <div class="flex gap-[30px]">
                                <div v-for="paymentMethod in PAYMENT_METHODS" :key="paymentMethod.id"
                                    class="flex gap-[5px] items-center justify-start">
                                    <input @input="selectedPayment" v-model="state.paymentMethod"
                                        :value="paymentMethod.name" type="radio" name="pMethod"
                                        :id="`pm${paymentMethod.id}`">
                                    <label :for="`pm${paymentMethod.id}`">{{ paymentMethod.name }}</label>
                                </div>
                            </div>
                            <div v-if="state.paymentMethod === PAYMENT_METHODS[STRIPE].name" class="mt-[50px]">
                                <h1 class="text-[17px]">Plătește prin <b>Stripe</b> folosind<span class="font-bold"> cardul
                                        de credit</span>.</h1>
                                <h2 class="my-[17px] ml-[3px] text-[#585858] text-[16px]">Pentru a asigura faptul că plata este
                                    securizată vei fi redirecționat către pagina oficială Stripe.</h2>
                                <MazBtn class="w-full px-0 py-[20px] mt-3" color="black" @click="makePaymentStripe"
                                    :loading="stripeLoading">
                                    Finalizează
                                </MazBtn>
                            </div>
                            <div v-else-if="state.paymentMethod === PAYMENT_METHODS[PAYPAL].name" class="mt-[50px]">
                                <h1 class="mb-[20px] text-[16px]"><span class="text-red-700 text-[23px]">*</span>Momentan această metodă
                                    de plată nu
                                    este
                                    disponibilă!</h1>
                                <!-- <h1 class="text-[17px]">Plătește prin <b>PayPal</b> folosind<b> cardul de credit</b> sau
                                                                                            <b>contul de PayPal</b>.
                                                                                        </h1>
    
                                                                                        <h2 class="my-[17px] ml-[3px] text-[#585858]">Pentru a asigura faptul că plata este
                                                                                            securizată vei fi redirecționat către pagina oficială PayPal.</h2> -->
                                <h1 class="text-[17px] text-gray-400">Plătește prin <b>PayPal</b> folosind<b> cardul de
                                        credit</b> sau
                                    <b>contul de PayPal</b>.
                                </h1>

                                <h2 class="my-[17px] ml-[3px] text-gray-400 text-[16px]">Pentru a asigura faptul că plata este
                                    securizată vei fi redirecționat către pagina oficială PayPal.</h2>
                                <MazBtn class="w-full px-0 py-[20px] mt-3" color="black" disabled>
                                    Finalizează
                                </MazBtn>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <Footer />
</template>