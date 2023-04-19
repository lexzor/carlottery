<script setup>
import { ref } from 'vue'
import NavBar from '../components/NavBar.vue'
import Footer from '../components/Footer.vue'
import { getEvents } from '@/additional/axiosPosts';
import { useRouter } from 'vue-router';
import LastCompetitions from '../components/LastCompetitions.vue'

const events = ref([])

const router = useRouter()

const retrieveEvents = async () => {
    events.value = await getEvents()
}

const goTo = (hashed_id) => {
    router.push({ path: `/evenimente/${hashed_id}` })
}

retrieveEvents()

</script>

<template>
    <NavBar />
    <LastCompetitions :maximumEventsToShow="5"></LastCompetitions>
    <Footer />
</template>