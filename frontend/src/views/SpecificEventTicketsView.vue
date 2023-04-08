<script setup>
import Navbar from '@/components/Navbar.vue';
import Footer from '@/components/Footer.vue';
import DataTable from 'datatables.net-vue3';
import Select from 'datatables.net-select'
import { useRoute } from 'vue-router'
import axios from 'axios';
import { ref } from 'vue';
import { getEvents } from '../additional/axiosPosts';

const tickets = ref()
const event = ref({})
const route = useRoute()

const getTickets = async () => {
    const allEvents = await getEvents()
    event.value = allEvents.filter(event => event.hashed_id === route.params.hashed_id)[0]

    console.log(event.value.id)
    await axios.post('http://localhost/loterie/getSpecificEventTickets.php', {
        "id": event.value.id
    }).catch(err => console.error).then(({data}) => {
        tickets.value = data
    })
}

DataTable.use(Select)
getTickets()
</script>

<template>
    <Navbar />
    <div class="container mx-auto px-0 mt-[77px]">
        <div class="xl:px-[45px] px-[25px]">
            <h1 class="text-[32px] font-medium text-[#000] mt-[40px]">BILETE ACHIZITIONATE</h1>
            <p class="text-[24px] text-[#000] font-light mt-[10px]">Vezi toate biletele cumparate pentru evenimentul <span class="font-bold">{{ event.title }}</span></p>
            <div class="mt-4" v-if="typeof tickets == 'object' && tickets.length > 0">
                <DataTable
                class="display"
                :data="tickets"
                :columns="[
                    { data: 'ticketId' },
                    { data: 'firstName' },
                    { data: 'lastName' }]">
                    <thead>
                        <tr>
                            <th>NR. Bilet</th>
                            <th>Nume</th>
                            <th>Prenume</th>
                        </tr>
                    </thead>
                </DataTable>
            </div>
            <div v-else-if="typeof tickets == 'object'" class="text-center">
                <h1 class="text-[#000] text-[32px] mt-5">Momentan nu este niciun bilet pentru acest eveniment!</h1>
                <div class="boxed-btn mt-5">
                    <router-link to="/" tag="button" class="relative text-white bg-[#000000] text-[19px] px-[42px] py-[16px] whitespace-nowrap">Intoarce-te</router-link>
                </div>
            </div>
            <div class="flex justify-center" v-else>
                <div class="flex items-center mt-[30px] gap-3">
                    <font-awesome-icon class="text-[36px] rotate text-[#000]" icon="fa-solid fa-spinner" />
                    <h3 class="text-[20px] text-[#000]">Loading...</h3>
                </div>
                
            </div>
        </div>
    </div>
    <Footer />
</template>

<style>
@import 'datatables.net-dt';
</style>