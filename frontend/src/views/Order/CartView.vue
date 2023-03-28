<script setup>
import NavBar from '../../components/NavBar.vue';
import { useAccountStore } from '../../stores/account';
import { useRouter } from 'vue-router';
import { getEvents } from '../../additional/axiosPosts'
import { ref, computed } from 'vue';
import MazBtn from 'maz-ui/components/MazBtn'
import MazInputNumber from 'maz-ui/components/MazInputNumber'

const account = useAccountStore()
const events = ref([])
const router = useRouter()

const retrieveEvents = async () => {
    const allEv = await getEvents()

    for(let i = 0; i < account.getStore().length; i++)
    {   
        let item = allEv.filter(ev => ev.id == account.getStore()[i].id)[0]

        if(item === undefined)
        {
            console.error(`Event with id '${account.getStore()[i].id}' has not been found for user [${account.getId()}] '${account.getUsername()}'`)
            continue
        }

        item['tickets'] = account.getStore()[i].tickets
        events.value.push(item)
    }

    if(!account.isLogged())
    {
        router.push({path: '/login'})
    }
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

const show = (value, id, pos) => {
    account.addItemStore(id, value - events.value[pos].tickets)
    events.value[pos].tickets = value
}

</script>

<template>
    <NavBar />
    <div class="mt-[200px] w-fit mx-auto">
        <div class="flex flex-col gap-[20px]">
            <div v-for="(item, index) in events" class="flex items-center justify-between gap-[20px] p-[5px] border-black border-[1px]">
                <img :src="'http://localhost/loterie/' + JSON.parse(item.images)[0]" class="max-w-[125px]">
                <div class="">
                    <h1>Eveniment</h1>
                    <h1 class="text">{{ item.title }}</h1>
                </div>
                <div>
                    <MazInputNumber @update:model-value="show($event, item.id, index)" :modelValue="item.tickets" label="Bilete" :min="1" />
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