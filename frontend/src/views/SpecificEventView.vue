<script setup>
import { ref, computed, onUnmounted } from 'vue';
import NavBar from '@/components/NavBar.vue'
import Footer from '../components/Footer.vue'
import { getEvents, getEventsTickets } from '@/additional/axiosPosts'
import { useRoute } from 'vue-router'
import router from '../router';
import MazInputNumber from 'maz-ui/components/MazInputNumber'
import MazBtn from 'maz-ui/components/MazBtn'
import { useAccountStore } from '../stores/account';
import { useToast } from 'vue-toast-notification';


const account = useAccountStore()
let imageIndex = ref(0);
const route = useRoute()
const currentEvent = ref({tickets: 0, remainingTime: 0})
const ticketNum = ref(1)
let interval = null

const retrieveEvents = async () => {
    const events = await getEvents()
    currentEvent.value = events.filter(event => event.hashed_id === route.params.hashed_id)[0]

    if(typeof currentEvent.value !== 'object' )
    {1
        router.push({path: '/evenimente'})
    }
    const tickets = await getEventsTickets()
    tickets.forEach(ticket => {
        if(ticket.event_id == currentEvent.value.id) {
            currentEvent.value.tickets = ticket.quantity
        }
    });
    currentEvent.value.remainingTime = Math.floor((formatTimeStamp(currentEvent.value.end) - new Date().getTime()) / 1000)
    
    interval = setInterval(() => {
        --currentEvent.value.remainingTime
    }, 1000)
}

const getRemainingTime = computed(() => {
    const seconds = Math.floor(currentEvent.value.remainingTime % 60) 
    const minutes = Math.floor((currentEvent.value.remainingTime / 60 ) % 60)
    const hours = Math.floor(((currentEvent.value.remainingTime / 60) / 60 ) % 24) 
    const days = Math.floor(((currentEvent.value.remainingTime / 60) / 60) / 24)
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

const redirectToFinishPayment = async () => {
    const toast = useToast()

    if(currentEvent.value.tickets == currentEvent.value.max_tickets) {
        toast.open({
            message: 'Ne pare rau! Toate biletele pentru acest event au fost cumparate!',
            duration: 5000,
            type: "info"
        })

        return
    }

    account.addItemStore(currentEvent.value.id, ticketNum.value)
    router.push({path: '/finish'})
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
    <div class="container mx-auto pl-0 mt-[77px]">
        <div class="xl:px-[45px] px-[25px]">
            <div class="grid xl:grid-cols-2 grid-cols-1 gap-4 items-start">
                <div class="flex gap-2 flex-col">
                    <div class="h-[500px] w-full bg-cover bg-center" :style="`background-image: url('http://localhost/loterie/${JSON.parse(currentEvent.images)[imageIndex]}'`"></div>
                    <div class="grid grid-cols-4 gap-2">
                        <div class="h-[140px] w-full bg-cover relative bg-center" :class="{ 'selected': imageIndex !== key }" @click="imageIndex = key;" v-for="(image, key) of JSON.parse(currentEvent.images)" :key="key" :style="`background-image: url('http://localhost/loterie/${image}'`"></div>
                    </div>
                </div>
                <div class="border-[1px] border-gray-300">
                    <div class="flex flex-col gap-2 p-3">
                        <h1 class="text-[30px] font-medium">{{ currentEvent.title }}</h1>
                        <h2 class="text-lg">Pret: <span class="font-medium">&euro;{{ currentEvent.price.toLocaleString() }}</span></h2>
                        <div>
                            <h2 class="text-lg">Descriere:</h2>
                            <p class="font-light text-gray-500">{{ currentEvent.description }}</p>
                        </div>
                    </div>
                    <div class="border-t-[1px] border-gray-300 p-3">
                        <h2 class="text-lg">Timp rămas:</h2>
                        <span class="font-medium text-[30px]">{{ getRemainingTime }}</span>
                        <h2 class="text-lg mt-2">Bilete cumparate: {{ currentEvent.tickets }}/{{ currentEvent.max_tickets }}</h2>
                        <div class="w-full bg-gray-200 rounded-full h-2.5 dark:bg-gray-700 mt-2">
                            <div class="bg-blue-600 h-2.5 rounded-full" :style="getTicketsProcent"></div>
                        </div>
                        <span v-if="account.getSpecificEventTickets(currentEvent.id) > 0">
                            Ai cumparat {{ account.getSpecificEventTickets(currentEvent.id) }} bilete
                        </span>
                    </div>
                    <div class="border-t-[1px] border-gray-300 p-3" v-if="currentEvent.tickets < currentEvent.max_tickets">
                        <div class="flex flex-col gap-3">
                            <div>
                                <h1 class="text-[30px] font-medium">Răspunde la întrebare</h1>
                                <h2 class="text-lg">Care este model de BMW:</h2>
                                <div class="flex gap-4">
                                    <div class="flex gap-2 justify-center items-center">
                                        <input type="radio" id="m5" name="question_answer" value="M5">
                                        <label for="m5">M5</label><br>
                                    </div>
                                    <div class="flex gap-2 justify-center items-center">
                                        <input type="radio" id="punto" name="question_answer" value="Punto">
                                        <label for="punto">Punto</label><br>
                                    </div>
                                    <div class="flex gap-2 justify-center items-center">
                                        <input type="radio" id="logan" name="question_answer" value="Logan">
                                        <label for="logan">Logan</label>
                                    </div>
                                </div>
                            </div>
                            <MazInputNumber v-model="ticketNum" :min="1" label="Bilete" />
                            <h1 class="font-bold text-[20px]">Total: &euro;{{ currentEvent.price * ticketNum }}</h1>
                            <div class="flex flex-row items-center gap-[10px]">
                                <MazBtn color="info" @click="redirectToFinishPayment">Cumpără</MazBtn>
                                <MazBtn @click="addEventInStore">Adaugă în cos</MazBtn>
                            </div>
                        </div> 
                    </div>
                    <div v-else>
                        <p class="px-3 pb-3">Au fost cumparate toate biletele pentru aceasta competitie</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <Footer />
</template>
<style lang="css" scoped>
.selected::after {
    content: '';
    position: absolute;
    background: rgba(0, 0, 0, 0.55);
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
}
</style>