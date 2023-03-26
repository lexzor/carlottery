<script setup>
import NavBar from '../../components/NavBar.vue';
import { useAccountStore } from '../../stores/account';
import { useRouter } from 'vue-router';
import { getEvents } from '../../additional/axiosPosts'
import { ref, computed } from 'vue';
import MazBtn from 'maz-ui/components/MazBtn'

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

</script>

<template>
    <NavBar />
    <div class="mt-[200px] w-[1500px] mx-auto">
        <div class="">
            <div v-for="item in events" class="flex items-center justify-between gap-[20px] p-[5px] border-black border-[1px]">
                <img :src="'http://localhost/loterie/' + JSON.parse(item.images)[0]" class="max-w-[125px]">
                <div class="">
                    <h1>Eveniment</h1>
                    <h1 class="text">{{ item.title }}</h1>
                </div>
                <div>
                    <h1>Bilete</h1>
                    <h1>{{ item.tickets }}</h1>
                </div>
                <div>
                    <h1>Pret Bilet</h1>
                    <h1>{{ item.price }}&#x20AC;</h1>
                </div>
                <div>
                    <h1>De plata</h1>
                    <h1>{{ item.tickets * item.price }}&#x20AC;</h1>
                </div>

                <MazBtn color="danger">Sterge</MazBtn>
            </div>
        </div>
    </div>
</template>