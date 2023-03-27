<script setup>
import NavBar from '../../components/NavBar.vue';
import { useAccountStore } from '../../stores/account';
import { useRouter } from 'vue-router';
import { getEvents } from '../../additional/axiosPosts'
import { ref, computed } from 'vue';
import MazBtn from 'maz-ui/components/MazBtn'
import MazInputNumber from 'maz-ui/components/MazInputNumber'

const account = useAccountStore()

if(!account.isLogged())
{
    const router = useRouter()
    router.push({path: '/'})
}

console.log(account.getStore())

const events = ref([])

const retrieveEvents = async () => {
    const allEv = await getEvents()

    account.getStore().forEach(storedItem => {
        console.table(storedItem)
        let item = allEv.filter(ev => ev.id == storedItem.eventId)[0]
        item['tickets'] = storedItem.tickets
        events.value.push(allEv.filter(ev => ev.id == storedItem.eventId)[0])
    })
    
    console.table(events.value)
}
retrieveEvents()

const removeItem = (itemid) => {
    events.value = events.value.filter(ev => ev.id !== itemid)
    account.removeItemStore(itemid)
}

const totalPrice = computed(() => {
    let totalPrice = 0

    events.value.forEach(event => {
        totalPrice += event['tickets'] * event['price']
    })

    return totalPrice
})

const checkEventTickets = (event) => {
    if(event.tickets < 1) {
        event.tickets = 1
    }

    console.log(event.tickets)
}

</script>

<template>
    <NavBar />
    <div class="mt-[200px] w-[1500px] mx-auto">
        <div class="flex flex-col gap-[20px]">
            <div v-for="item in events" class="flex items-center justify-between gap-[20px] p-[5px] border-black border-[1px]">
                <img :src="'http://localhost/loterie/' + JSON.parse(item.images)[0]" class="max-w-[125px]">
                <div class="">
                    <h1>Eveniment</h1>
                    <h1 class="text">{{ item.title }}</h1>
                </div>
                <div>
                    <MazInputNumber label="Bilete" v-model="item.tickets" :min="1" />
                </div>
                <div>
                    <h1>Pret Bilet</h1>
                    <h1>{{ item.price }}&#x20AC;</h1>
                </div>
                <div>
                    <h1>De plata</h1>
                    <h1>{{ item.tickets * item.price }}&#x20AC;</h1>
                </div>

                <MazBtn color="danger" @click="removeItem(item.id)">Sterge</MazBtn>
            </div>
        </div>

        <div class="flex justify-center mt-[20px]">
            <h1 class="text-[20px]">Total de plata:<span class="font-bold ml-[10px]">{{ totalPrice }}&#x20AC</span></h1>
        </div>
    </div>
</template>