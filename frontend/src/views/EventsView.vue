<script setup>
import { ref } from 'vue'
import NavBar from '../components/NavBar.vue' 
import { getEvents } from '@/additional/axiosPosts';
import { useRouter } from 'vue-router';

const events = ref([])

const router = useRouter()

const retrieveEvents = async () => {
    events.value = await getEvents()
} 

const goTo = (hashed_id) => {
    router.push({path: `/evenimente/${hashed_id}`})
}

retrieveEvents()

</script>

<template>
    <NavBar />
    <div class="w-[80%] mx-auto mt-[100px]">
        <h1>Toate competitiile noastre!</h1>
        <div class="flex gap-[20px] mt-[60px]">
            <div v-for="(event, index) in events" :key="index" :style="`background-image: url('http://localhost/loterie/${JSON.parse(event.images)[0]}'`" class="w-[270px] h-[150px] bg-slate-200 flex justify-center items-center flex-col gap-[20px] bg-no-repeat bg-contain bg-center">
                <h1 class="text-white">{{ event.title }}</h1>
                <button class="px-[10px] py-[10px] bg-red-100" @click="goTo(event.hashed_id)">Participa</button>
            </div>
        </div>
    </div>
</template>