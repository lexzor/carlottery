<script setup>
import { ref, computed, onUnmounted } from 'vue';
import NavBar from '@/components/NavBar.vue'
import { getEvents, getEventsTickets } from '@/additional/axiosPosts'
import { useRoute } from 'vue-router'
import router from '../router';
import MazInputNumber from 'maz-ui/components/MazInputNumber'
import MazBtn from 'maz-ui/components/MazBtn'
import { useAccountStore } from '../stores/account';
import { useToast } from 'vue-toast-notification';
import axios from "axios"

const account = useAccountStore()

const route = useRoute()
const currentEvent = ref({tickets: 0, remainingTime: 0}) // am adaugat tickets default value pentru ca dadea eroare cand monta dom-ul din cauza delayului celui de-al doilea post (cel pt biele)
const ticketNum = ref(1)
const cardElement = ref(null)
let interval = null

const retrieveEvents = async () => {
    const events = await getEvents()
    currentEvent.value = events.filter(event => event.hashed_id === route.params.hashed_id)[0]
    
    if(typeof currentEvent.value !== 'object' )
    {
        router.push({path: '/evenimente'})
    }
    
    currentEvent.value.tickets = await getEventsTickets() === null ? 0 : tickets.filter(ticket => ticket.eid === currentEvent.value.id).length
    currentEvent.value.remainingTime = formatTimeStamp(currentEvent.value.end) - new Date().getTime()
    
    interval = setInterval(() => {
        --currentEvent.value.remainingTime
    }, 1000)
}

const getRemainingTime = computed(() => {
    console.log(currentEvent.value.remainingTime)
    const days = Math.floor(currentEvent.value.remainingTime / (3600*24) )
    const hours = Math.floor(currentEvent.value.remainingTime / 3600)
    const minutes = Math.floor(currentEvent.value.remainingTime / 60)
    const seconds = Math.floor(currentEvent.value.remainingTime % 60)
    return `${days < 10 ? "0" : ""}${days}:${hours < 10 ? "0" : ""}${hours}:${minutes < 10 ? "0" : ""}${minutes}:${seconds < 10 ? "0" : ""}${seconds}`
})

const formatTimeStamp = (time) => {
    const evDate = time.split(' ')
    const splittedDate = evDate[0].split('-')
    const correctlyFormatedDate = `${splittedDate[1]}/${splittedDate[0]}/${splittedDate[2]} ${evDate[1]}:00`
    return Date.parse(correctlyFormatedDate)
}

retrieveEvents()

const getTicketsProcent = computed(() => {
    return `width: ${(100 * currentEvent.value.tickets) / currentEvent.value.max_tickets}%`;
})

const makePayment = async () => {
    const toast = useToast()

    if(currentEvent.value.tickets == currentEvent.value.max_tickets) {
        toast.open({
            message: 'Ne pare rau! Toate biletele pentru acest event au fost cumparate!',
            duration: 5000,
            type: "info"
        })

        return
    }

    const { data } = await axios.post('http://localhost/loterie/makePayment.php', {
        'quantity': ticketNum.value * currentEvent.value.price,
        'event_id': currentEvent.value.id
    }, {
        headers: {
          "Content-Type": "application/json",
        },
    })

    window.location.href = data
}

const addEventInStore = async () => {
    const toast = useToast()

    if (!account.isLogged()) {

        toast.open({
            message: 'Trebuie sa fii logat pentru a adauga in cos!',
            duration: 5000,
            type: "info"
        })

        return
    }

    account.addItemStore(currentEvent.value.id, ticketNum.value)

    toast.open({
        message: `Ai adaugat in cos ${ticketNum.value} ${ticketNum.value == 1 ? "bilet" : "bilete"} pentru acest eveniment!`,
        duration: 5000,
        type: "success"
    })
}


onUnmounted(() => {
    clearInterval(interval)
})
</script>

<template>
    <NavBar />
    <div class="w-[80%] mx-auto mt-[100px] flex flex-col gap-5">
        <div class="max-w-[300px]">
            <h1>Bilete cumparate: {{ currentEvent.tickets }}/{{ currentEvent.max_tickets }}</h1>
            <div class="w-full bg-gray-200 rounded-full h-2.5 dark:bg-gray-700">
                <div class="bg-blue-600 h-2.5 rounded-full" :style="getTicketsProcent"></div>
            </div>
        </div>

        <div class="max-w-fit">
            <div v-if="currentEvent.tickets < currentEvent.max_tickets" class="flex flex-col gap-[20px]">
                <h1>Participa cumparand un bilet! Remaining time</h1>
                <h1>{{ getRemainingTime }}</h1>
                <h1 class="font-bold text-[20px]">Pret bilet: {{ currentEvent.price }}&euro;</h1>
                <div class="flex items-center justify-between gap-[20px] flex-col">
                    <MazInputNumber v-model="ticketNum" :min="1" label="Bilete" />
                    <h1 class="font-bold text-[20px]">Total: {{ currentEvent.price * ticketNum }}&euro;</h1>
                    <div class="flex flex-col justify-center items-center gap-[20px]">
                        <MazBtn @click="makePayment"> CUMPARA </MazBtn>
                        <h1>SAU</h1>
                        <MazBtn @click="addEventInStore"> Adauga in cos </MazBtn>
                    </div>
                </div>
            </div>
            <div v-else>Au fost cumparate toate biletele pentru aceasta competitie</div>
        </div>
</div>
</template>