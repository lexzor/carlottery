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

const currentEvent = ref({images: ['["events_images/struggle.png"]'], price: 0})
const account = useAccountStore()
const imageIndex = ref(0);
const route = useRoute()
const ticketNum = ref(1)
let interval = null

const retrieveEvents = async () => {
    const events = await getEvents()
    currentEvent.value = events.filter(event => event.hashed_id === route.params.hashed_id)[0]

    if(typeof currentEvent.value !== 'object' )
    {
        router.push({path: '/evenimente'})
    }

    const tickets = await getEventsTickets()

    tickets.forEach(ticket => {
        if(ticket.event_id == currentEvent.value.id) {
            currentEvent.value.tickets = ticket.quantity
        }
    });

    console.log(currentEvent.value)

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
    return seconds > 0 ? `${days < 10 ? "0" : ""}${days}:${hours < 10 ? "0" : ""}${hours}:${minutes < 10 ? "0" : ""}${minutes}:${seconds < 10 ? "0" : ""}${seconds}` : 0
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
    <div class="container mx-auto px-0 mt-[77px]">
        <div class="xl:px-[45px] px-[25px]">
            <div class="grid xl:grid-cols-2 grid-cols-1 gap-4 items-start">
                <div class="flex gap-2 flex-col">
                    <div class="h-[500px] w-full bg-cover bg-center" :style="`background-image: url('http://localhost/loterie/${JSON.parse(currentEvent.images)[imageIndex]}'`"></div>
                    <div class="grid grid-cols-4 gap-2">
                        <div class="h-[140px] w-full bg-cover relative bg-center" :class="{ 'selected': imageIndex !== key }" @click="imageIndex = key;" v-for="(image, key) in JSON.parse(currentEvent.images)" :key="key" :style="`background-image: url('http://localhost/loterie/${image}'`"></div>
                    </div>
                </div>
                <div class="border-[1px] border-gray-300">
                    <div class="flex flex-col gap-2 p-3">
                        <h1 class="text-[30px] font-medium text-black">{{ currentEvent.title }}</h1>
                        <h2 class="text-lg font-normal text-black">Pret: <span class="font-medium">&euro;{{ currentEvent.price.toLocaleString() }}</span></h2>
                        <div>
                            <h2 class="text-lg text-black">Descriere:</h2>
                            <p class="font-light text-gray-500">{{ currentEvent.description }}</p>
                        </div>
                    </div>
                    <div class="border-t-[1px] border-gray-300 p-3">
                        <div v-if="typeof getRemainingTime === 'string'">
                            <h2 class="text-lg text-black">Timp rămas:</h2>
                            <span class="font-medium text-[30px] text-black">{{ getRemainingTime }}</span>
                        </div>
                        <h2 class="text-lg mt-2 text-black">Bilete cumparate: {{ currentEvent.tickets }}<span class="text-red-500">/</span>{{ currentEvent.max_tickets }}</h2>
                        <div class="w-full bg-gray-200 rounded-full h-2.5 dark:bg-gray-700 mt-2">
                            <div class="bg-black h-2.5 rounded-full" :style="getTicketsProcent"></div>
                        </div>
                        <span v-if="account.getSpecificEventTickets(currentEvent.id) > 0" class="mt-[100px]">
                            Ai cumparat {{ account.getSpecificEventTickets(currentEvent.id) }} bilete
                        </span>
                    </div>
                    <div class="border-t-[1px] border-gray-300 p-3" v-if="currentEvent.tickets < currentEvent.max_tickets && typeof getRemainingTime === 'string'">
                        <div class="flex flex-col gap-3">
                            <div>
                                <h1 class="text-[30px] font-medium text-black">Răspunde la întrebare</h1>
                                <h2 class="text-lg mt-3 mb-2">Care este model de BMW:</h2>
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
                        </div> 
                    </div>
                    <div v-if="typeof getRemainingTime === 'string'" class="border-t-[1px] border-gray-300 p-3">
                        <h2 class="text-lg mb-2 text-black font-normal">Alege-ti numarul de bilete pe care vrei sa-l achizitionezi:</h2>
                        <MazInputNumber class="w-full" v-model="ticketNum" :min="1" label="Bilete" />
                    </div>
                    <div v-if="typeof getRemainingTime === 'string'" class="border-t-[1px] border-gray-300 p-3">
                        <h1 class="font-normal text-[20px] mb-3 text-black">Total: <span class="font-semibold text-black">&euro;{{ currentEvent.price * ticketNum }}</span></h1>
                        <div class="flex flex-row items-center gap-[10px]">
                            <MazBtn @click="redirectToFinishPayment">Cumpără</MazBtn>
                            <MazBtn outline class="border-black" @click="addEventInStore">Adaugă în cos</MazBtn>
                        </div>
                    </div>
                    <div v-else class="border-t-[1px] border-gray-300 p-3">
                        <h1 class="font-normal text-[20px] mb-3 text-black"><router-link :to="`/bilete/${currentEvent.hashed_id}`" tag="span" class="font-semibold text-black underline">Click</router-link> pentru a vedea biletele</h1>
                    </div>
                    <div v-if="currentEvent.tickets >= currentEvent.max_tickets">
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