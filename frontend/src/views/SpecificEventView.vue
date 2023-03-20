<script setup>
import { ref, computed, onMounted, reactive } from 'vue';
import NavBar from '@/components/NavBar.vue'
import { getEvents, getEventsTickets } from '@/additional/axiosPosts'
import { useRoute } from 'vue-router'
import router from '../router';
import MazInputNumber from 'maz-ui/components/MazInputNumber'
import MazBtn from 'maz-ui/components/MazBtn'
import { useAccountStore } from '../stores/account';
import { useToast } from 'vue-toast-notification';
import axios from "axios"

const route = useRoute()
const currentEvent = ref(null)
const ticketNum = ref(1)
const cardElement = ref(null)



const retrieveEvents = async () => {
    const events = await getEvents()
    currentEvent.value = events.filter(event => event.hashed_id === route.params.hashed_id)[0]
    
    if(typeof currentEvent.value !== 'object' )
    {
        router.push({path: '/evenimente'})
    }

    const tickets = await getEventsTickets()

    currentEvent.value['tickets'] = tickets === null ? 0 : tickets.filter(ticket => ticket.eid === currentEvent.value.id).length

    console.table(currentEvent.value)
}

retrieveEvents()

const getTicketsProcent = computed(() => {
    return `width: ${(100 * currentEvent.value.tickets) / currentEvent.value.max_tickets}%`;
})

const addInCart = () => {
    const account = useAccountStore()
    account.addItemStore(currentEvent.value.id)

    const toast = useToast()

    toast.open({
        
    })
}

const makePayment = async () => {
    const { data } = await axios.post('http://localhost/loterie/makePayment.php', {
        'quantity': 2,
        'event_id': 66
    },
    {
        headers: {
          "Content-Type": "application/json",
        },
    })

    window.location.href = data
}

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
            <div v-if="currentEvent.tickets < currentEvent.max_tickets">
                <h1>Participa cumparand un bilet!</h1>
                <div class="flex items-center justify-between gap-[20px]">
                    <MazInputNumber v-model="ticketNum" label="Bilete" />
                    <MazBtn @click="addInCart"> Adauga in cos </MazBtn>
                    <MazBtn @click="makePayment"> CUMPARA </MazBtn>
                    <div ref="cardElement"></div>
                </div>
            </div>
            <div v-else>Au fost cumparate toate biletele pentru aceasta competitie</div>
        </div>
</div>
</template>