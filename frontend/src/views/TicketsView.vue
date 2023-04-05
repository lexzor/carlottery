<script setup>
import LastCompetitions from '../components/LastCompetitions.vue';
import { getEvents } from '../additional/axiosPosts';
import { ref } from 'vue';
import Navbar from '@/components/Navbar.vue';

const events = ref([])

const retrieveEvents = async () => {
    events.value = await getEvents()
}

retrieveEvents

</script>
<template>
    <Navbar />
    <div>
        <LastCompetitions :displayingOnTicketsPage="true" />
    </div>
</template>