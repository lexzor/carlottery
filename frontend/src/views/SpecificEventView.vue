<script setup>
import { ref, computed } from 'vue';
import NavBar from '@/components/NavBar.vue'
import { getEvents, getEventsTickets } from '@/additional/axiosPosts'
import { useRoute } from 'vue-router'
import router from '../router';

const route = useRoute()
const currentEvent = ref(null)

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

</script>

<template>
    <NavBar />
    <div class="w-[80%] mx-auto mt-[100px]">
        <div class="max-w-[300px]">
            <h1>Bilete cumparate: {{ currentEvent.tickets }}/{{ currentEvent.max_tickets }}</h1>
            <div class="w-full bg-gray-200 rounded-full h-2.5 dark:bg-gray-700">
                <div class="bg-blue-600 h-2.5 rounded-full" :style="getTicketsProcent"></div>
            </div>
        </div>

        <div class="">
            <div v-if="currentEvent.tickets < currentEvent.max_tickets">Participa cumparand un bilet!</div>
            <div v-else>Au fost cumparate toate biletele pentru aceasta competitie</div>
        </div>
</div>
</template>