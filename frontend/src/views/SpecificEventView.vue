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
import axios from 'axios';
import '@/assets/popper-theme.css'
import Popper from "vue3-popper"

const BASE_URL = import.meta.env.VITE_SERVER_BASE_URL

const currentEvent = ref({ images: ['["events_images/struggle.png"]'], price: 0 })
const account = useAccountStore()
const imageIndex = ref(0);
const route = useRoute()
const ticketNum = ref(1)
const quiz = ref({})
const currUserAnswer = ref()
const time = ref(0)
let interval = null

const retrieveEvents = async () => {
    const events = await getEvents()
    currentEvent.value = events.filter(event => event.hashed_id === route.params.hashed_id)[0]

    if (typeof currentEvent.value !== 'object') {
        router.push({ path: '/evenimente' })
    }

    const tickets = await getEventsTickets()

    tickets.forEach(ticket => {
        if (ticket.event_id == currentEvent.value.id) {
            currentEvent.value.tickets = ticket.quantity
        }
        currentEvent.value.tickets = 0
    });


    time.value = Math.floor((formatTimeStamp(currentEvent.value.end) - new Date().getTime()) / 1000)

    if (time.value > 0) {
        interval = setInterval(() => {
            --time.value

            if (time.value < 0) {
                clearInterval(interval)
                interval = null
            }
        }, 1000)
    }
    await axios.post(BASE_URL + "anti_gdpr.php")
        .catch(err => console.error)
        .then(({ data }) => {
            quiz.value = data[Math.floor(Math.random() * data.length)]
        })
}

const getRemainingTime = computed(() => {
    const seconds = Math.floor(time.value % 60)
    const minutes = Math.floor((time.value / 60) % 60)
    const hours = Math.floor(((time.value / 60) / 60) % 24)
    const days = Math.floor(((time.value / 60) / 60) / 24)
    return time.value > 0 ? `${days < 10 ? "0" : ""}${days}:${hours < 10 ? "0" : ""}${hours}:${minutes < 10 ? "0" : ""}${minutes}:${seconds < 10 ? "0" : ""}${seconds}` : new Number(1)
})

const formatTimeStamp = (timeParam) => {
    const evDate = timeParam.split(' ')
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

    if (currentEvent.value.tickets == currentEvent.value.max_tickets) {
        toast.open({
            message: 'Ne pare rău! Toate biletele pentru acest eveniment au fost cumpărate!',
            duration: 5000,
            type: "info"
        })

        return
    }

    account.addItemStore(currentEvent.value.id, ticketNum.value, currUserAnswer.value)
    router.push({ path: '/finish' })
}

const addEventInStore = async () => {
    const toast = useToast()

    if (!account.isLogged()) {

        toast.open({
            message: 'Trebuie să fii logat pentru a adaugă in coș!',
            duration: 5000,
            type: "error"
        })

        return
    }

    account.addItemStore(currentEvent.value.id, ticketNum.value, currUserAnswer.value)

    toast.open({
        message: `Ai adăugat in coș <span class="font-semibold">${ticketNum.value} ${ticketNum.value == 1 ? "bilet" : "bilete"}</span> pentru acest eveniment!`,
        duration: 5000,
        type: "success"
    })
}

const answerChecker = computed(() => {
    if (currUserAnswer.value !== quiz.value.c) {
        return true
    }

    return false
})

const updateAnswer = (value) => {
    currUserAnswer.value = value
}


onUnmounted(() => {
    if (interval !== null) {
        clearInterval(interval)
        interval = null
    }
})
</script>

<template>
    <NavBar />
    <div class="container mx-auto px-0 mt-[77px]">
        <div class="xl:px-[45px] px-[25px]">
            <div class="grid xl:grid-cols-2 grid-cols-1 gap-4 items-start">
                <div class="flex gap-2 flex-col">
                    <div class="h-[500px] w-full bg-cover bg-center"
                        :style="`background-image: url('${BASE_URL + JSON.parse(currentEvent.images)[imageIndex]}'`"></div>
                    <div class="grid grid-cols-4 gap-2">
                        <div class="h-[140px] w-full bg-cover relative bg-center"
                            :class="{ 'selected': imageIndex !== key }" @click="imageIndex = key;"
                            v-for="(image, key) in JSON.parse(currentEvent.images)" :key="key"
                            :style="`background-image: url('${BASE_URL + image}'`"></div>
                    </div>
                </div>
                <div class="border-[1px] border-gray-300">
                    <div class="flex flex-col gap-2 p-3">
                        <h1 class="text-[30px] font-medium text-black">{{ currentEvent.title }}</h1>
                        <h2 class="text-lg font-normal text-black">Pret: <span class="font-medium">&euro;{{
                            currentEvent.price.toLocaleString() }}</span></h2>
                        <div>
                            <h2 class="text-lg text-black">Descriere:</h2>
                            <div v-html="currentEvent.description"></div>
                        </div>
                    </div>
                    <div class="border-t-[1px] border-gray-300 p-3">
                        <div v-if="typeof getRemainingTime === 'string'">
                            <h2 class="text-lg text-black">Timp rămas:</h2>
                            <span class="font-medium text-[30px] text-black">{{ getRemainingTime }}</span>
                        </div>
                        <h2 class="text-lg mt-2 text-black">Bilete cumpărate: {{ currentEvent.tickets }}<span
                                class="text-red-500">/</span>{{ currentEvent.max_tickets }}</h2>
                        <div class="w-full bg-gray-200 rounded-full h-2.5 dark:bg-gray-700 mt-2">
                            <div class="bg-black h-2.5 rounded-full" :style="getTicketsProcent"></div>
                        </div>
                        <span v-if="account.getSpecificEventTickets(currentEvent.id) > 0" class="mt-[100px]">
                            Ai cumpărat {{ account.getSpecificEventTickets(currentEvent.id) }} bilete
                        </span>
                    </div>
                    <div class="border-t-[1px] border-gray-300 p-3"
                        v-if="currentEvent.tickets < currentEvent.max_tickets && typeof getRemainingTime === 'string'">
                        <div class="flex flex-col gap-3">
                            <div>
                                <h1 class="text-[30px] font-medium text-black">Răspunde la întrebare</h1>
                                <h2 class="text-lg mt-3 mb-2">{{ quiz.question }}</h2>
                                <div class="flex xl:flex-row flex-col gap-4">
                                    <div class="flex gap-2 xl:justify-center justify-start items-center">
                                        <label for="a" @click="updateAnswer(quiz.a)">
                                            <input :checked="currUserAnswer === quiz.a" v-bind:value="currUserAnswer"
                                                type="radio" name="question_answer" value="a">
                                            {{ quiz.a }}
                                        </label><br>
                                    </div>
                                    <div class="flex gap-2 xl:justify-center justify-start items-center">
                                        <label for="b" @click="updateAnswer(quiz.b)">
                                            <input :checked="currUserAnswer === quiz.b" v-bind:value="currUserAnswer"
                                                type="radio" name="question_answer" value="b">
                                            {{ quiz.b }}
                                        </label><br>
                                    </div>
                                    <div class="flex gap-2 xl:justify-center justify-start items-center">
                                        <label for="c" @click="updateAnswer(quiz.c)">
                                            <input :checked="currUserAnswer === quiz.c ? true : false"
                                                v-bind:value="currUserAnswer" type="radio" name="question_answer" value="c">
                                            {{ quiz.c }}
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div v-if="typeof getRemainingTime === 'string'" class="border-t-[1px] border-gray-300 p-3">
                        <h2 class="text-lg mb-2 text-black font-normal">Alege numărul de bilete pe care vrei să-l
                            achiziționezi:</h2>
                        <MazInputNumber class="w-full" v-model="ticketNum" :min="1" label="Bilete" />
                    </div>
                    <div v-if="typeof getRemainingTime === 'string'" class="border-t-[1px] border-gray-300 p-3">
                        <h1 class="font-normal text-[20px] mb-3 text-black">Total: <span
                                class="font-semibold text-black">&euro;{{ currentEvent.price * ticketNum }}</span></h1>
                        <div class="flex flex-row items-center gap-[10px]">
                            <Popper :interactive="false" :arrow="true" :disabled="answerChecker ? false : true" hover
                                content="Trebuie să răspunzi la întrebare pentru a cumpăra">
                                <MazBtn :disabled="answerChecker" @click="redirectToFinishPayment">Cumpără</MazBtn>
                            </Popper>
                            <Popper :interactive="false" :arrow="true" :disabled="answerChecker ? false : true" hover
                                content="Trebuie să răspunzi la întrebare pentru a adăuga in coș">
                                <MazBtn :disabled="answerChecker" :outline="answerChecker ? false : true"
                                    class="border-black" @click="addEventInStore">
                                    Adaugă în cos</MazBtn>
                            </Popper>
                        </div>
                    </div>
                    <div v-else class="border-t-[1px] border-gray-300 p-3 flex gap-3">
                        <router-link :to="`/bilete/${currentEvent.hashed_id}`">
                            <MazBtn class="border-black">Bilete cumpărate</MazBtn>
                        </router-link>
                        <router-link :to="`/castigatori/${currentEvent.hashed_id}`">
                            <MazBtn class="border-black">Câștigător</MazBtn>
                        </router-link>
                    </div>
                    <div v-if="currentEvent.tickets >= currentEvent.max_tickets">
                        <p class="px-3 pb-3">Au fost cumpărate toate biletele pentru această competiție</p>
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