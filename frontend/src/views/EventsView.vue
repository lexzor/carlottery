<script setup>
import { ref } from 'vue'
import axios from 'axios'
import NavBar from '../components/NavBar.vue' 
import { getEvents } from '@/additional/axiosPosts';

const events = ref([])

const retrieveEvents = async () => {
    events.value = await getEvents()
} 

retrieveEvents()

</script>

<template>
    <NavBar />
    <div class="w-[80%] mx-auto mt-[100px]">
        <h1>Toate competitiile noastre!</h1>
        <div class="">
            <div v-for="(event, index) in events" :key="index">
                <h1>{{ event.title }}</h1>

            </div>
        </div>
    </div>
</template>