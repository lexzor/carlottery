<script setup>
import Navbar from '@/components/Navbar.vue';
import DataTable from 'datatables.net-vue3';
import Select from 'datatables.net-select'
import { useRoute } from 'vue-router'
import axios from 'axios';
import { ref } from 'vue';
import { getEvents } from '../additional/axiosPosts';

const tickets = ref()
const event = ref({})
const route = useRoute()

console.log(route.params.hashed_id)

const getTickets = async () => {
    const allEvents = await getEvents()
    event.value = allEvents.filter(event => event.hashed_id === route.params.hashed_id)[0]

    await axios.post('http://localhost/loterie/getSpecificEventTickets.php', {
        "id": event.value.id
    }).catch(err => console.error).then(({data}) => {
        tickets.value = data
    })
}

DataTable.use(Select)
getTickets()

// const dataTable

</script>

<template>
    <Navbar />
    <div class="mt-[100px] mx-auto w-[1200px] h-fit">
        <h1>Bilete pentru evenimentul <span class="font-bold mb-[20px]">{{event.title}}</span></h1>
        <div v-if="typeof tickets == 'object' && tickets.length > 0">
            <DataTable
            class="display"
            :data="tickets"
            :columns="[
                { data: 'ticketId' },
                { data: 'firstName' },
                { data: 'lastName' }
                    ]">
                <thead>
                    <tr>
                        <th>NR. Bilet</th>
                        <th>Nume</th>
                        <th>Prenume</th>
                    </tr>
                </thead>
            </DataTable>
        </div>
        <div v-else-if="typeof tickets == 'object'">
            <h1>Momentan nu este niciun bilet pentru acest eveniment!</h1>
        </div>
        <div v-else>
            <h1>Loading...</h1>
        </div>
    </div>
</template>