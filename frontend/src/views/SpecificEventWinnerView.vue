<script setup>
import { ref } from 'vue';
import NavBar from '../components/NavBar.vue';
import Footer from '../components/Footer.vue';
import { getEvents } from '../additional/axiosPosts';
import { useRoute } from 'vue-router';
import router from '../router';


const BASE_URL = import.meta.env.VITE_SERVER_BASE_URL
const route = useRoute()
const event = ref({ title: '', images: ['["events_images/struggle.png"]'] })
const imageIndex = ref(0);

const retrieveEvents = async () => {
    const events = await getEvents()

    event.value = events.filter(ev => ev.hashed_id === route.params.hashed_id)[0]

    if (event.value === undefined) {
        router.push({ path: '/castigatori' })
        return
    }
}
retrieveEvents()
</script>

<template>
    <NavBar />
    <div class="container mt-[100px] mx-auto">
        <h1 class="text-[19px]">Titlu: <span class="font-bold">{{ event.title }}</span></h1>

        <div class="flex flex-col gap-[20px]">
            <div>
                <h1 class="text-[19px]">Despre eveniment:</h1>
                <div v-html="event.description"></div>
            </div>

            <div>
                <div v-html="event.winnerText">
                </div>
            </div>
        </div>

        <div class="flex gap-2 flex-col">
            <h1>Poze eveniment</h1>
            <div class="h-[500px] w-full bg-cover bg-center"
                :style="`background-image: url('${BASE_URL + JSON.parse(event.images)[imageIndex]}'`"></div>
            <div class="grid grid-cols-4 gap-2">
                <div class="h-[140px] w-full bg-cover relative bg-center" :class="{ 'selected': imageIndex !== key }"
                    @click="imageIndex = key;" v-for="(image, key) in JSON.parse(event.images)" :key="key"
                    :style="`background-image: url('${BASE_URL + image}'`"></div>
            </div>
        </div>
    </div>
    <Footer />
</template>