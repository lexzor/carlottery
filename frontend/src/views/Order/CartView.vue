<script setup>
import NavBar from '../../components/NavBar.vue';
import Footer from '../../components/Footer.vue'
import { useAccountStore } from '../../stores/account';
import { useRouter } from 'vue-router';
import { getEvents } from '../../additional/axiosPosts'
import { ref, computed } from 'vue';
import MazBtn from 'maz-ui/components/MazBtn'

const BASE_URL = import.meta.env.VITE_SERVER_BASE_URL

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
            console.error(`Event with id '${account.getStore()[i].id}' has not been found for user [${account.getId()}] '${account.getUsername()}' in database events list and will be deleted from user store`)
            account.removeItemStore(account.getStore()[i].id)
            continue
        }

        item['tickets'] = account.getStore()[i].tickets
        events.value.push(item)
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
</script>

<template>
    <NavBar />
    <div class="container mx-auto px-0 mt-[77px] mb-[12.81%]">
        <div class="xl:px-[45px] px-[25px]">
            <div class="bg-white shadow rounded">
                <div>
                    <div class="xl:p-10 p-4">
                        <h1 class="uppercase text-[20px] font-bold text-[#000]">Coş cu produse</h1>
                        <h1 class="mt-2 text-slate-600">Vizualizează toate biletele pe care vrei să le achiziționezi</h1>
                    </div>
                    <div class="relative overflow-x-auto sm:rounded-lg">
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400 border-b">
                                <tr>
                                    <th scope="col" class="px-6 py-3">
                                        Produs
                                    </th>
                                    <th scope="col" class="px-6 py-3">
                                        Cantitate
                                    </th>
                                    <th scope="col" class="px-6 py-3">
                                        Preț
                                    </th>
                                    <th scope="col" class="px-6 py-3">
                                        
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(item, index) in events" :key="item.id" :class="{'bg-gray-50': index % 2 == 1}" class="border-b dark:bg-gray-900 dark:border-gray-700">
                                    <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white flex items-center gap-3">
                                        <div :style="`background-image: url('${BASE_URL + JSON.parse(item.images)[0]}')`" class="w-[100px] h-[50px] bg-center bg-cover bg-no-repeat rounded"></div> {{ item.title }}
                                    </th>
                                    <td class="px-6 py-4">
                                        {{ item.tickets }} buc.
                                    </td>
                                    <td class="px-6 py-4">
                                        {{ item.price }}&#x20AC;
                                    </td>
                                    <td class="px-6 py-4">
                                        <MazBtn class="btn-cart" size="sm" outline color="danger" @click="removeItem(item.id)">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" viewBox="0 0 24 24" style="fill: rgba(255, 110, 107, 1);transform: ;msFilter:;"><path d="M5 20a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V8h2V6h-4V4a2 2 0 0 0-2-2H9a2 2 0 0 0-2 2v2H3v2h2zM9 4h6v2H9zM8 8h9v12H7V8z"></path><path d="M9 10h2v8H9zm4 0h2v8h-2z"></path></svg>
                                        </MazBtn>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div v-if="events.length > 0" class="xl:p-10 p-4 flex justify-between items-center xl:flex-row flex-col xl:gap-0 gap-4 text-black">
                        <h3 class="text-slate-700 flex gap-3 items-center">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" style="fill: rgba(255, 110, 107, 1);transform: ;msFilter:;"><path d="M12 2C6.486 2 2 6.486 2 12s4.486 10 10 10 10-4.486 10-10S17.514 2 12 2zm0 18c-4.411 0-8-3.589-8-8s3.589-8 8-8 8 3.589 8 8-3.589 8-8 8z"></path><path d="M11 11h2v6h-2zm0-4h2v2h-2z"></path></svg>
                            Vizualizați cu atenție toate produsele pe care le-ați introdus în coş
                        </h3>
                        <div class="flex gap-4">
                            <div class="text-right">
                                <h1 class="mb-2">Subtotal</h1>
                                <h1 class="uppercase text-[20px] font-bold">{{ totalPrice }}&#x20AC</h1>
                            </div>
                            <MazBtn @click="router.push({path: '/finish'})">
                                Continuă
                                <svg xmlns="http://www.w3.org/2000/svg" class="ml-2" width="24" height="24" viewBox="0 0 24 24" style="fill: rgba(255, 255, 255, 1);transform: ;msFilter:;"><path d="m11.293 17.293 1.414 1.414L19.414 12l-6.707-6.707-1.414 1.414L15.586 11H6v2h9.586z"></path></svg>
                            </MazBtn>
                        </div>
                    </div>
                    <div v-else class="xl:p-10 p-4 flex justify-between items-center xl:flex-row flex-col xl:gap-0 gap-4 text-black">
                            <h3 class="text-slate-700 flex gap-3 items-center">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" style="fill: rgba(255, 110, 107, 1);transform: ;msFilter:;"><path d="M12 2C6.486 2 2 6.486 2 12s4.486 10 10 10 10-4.486 10-10S17.514 2 12 2zm0 18c-4.411 0-8-3.589-8-8s3.589-8 8-8 8 3.589 8 8-3.589 8-8 8z"></path><path d="M11 11h2v6h-2zm0-4h2v2h-2z"></path></svg>
                                Momentan nu aveți niciun produs in coş
                            </h3>
                        </div>
                </div>
            </div>
            <!-- <div class="w-full mx-auto">
                <h3 class="text-[32px] font-medium text-[#000]">Co??��l cu cump?��r?��turi:</h3>
                <p class="text-[24px] text-[#000] font-light mb-[10px]">Toate produsele din co??.</p>
                <div class="flex flex-col gap-[20px]">
                    <div v-for="(item, index) in events" class="flex flex-wrap xl:flex-row flex-col items-center justify-between gap-[20px] p-[5px] border-black border-[1px]">
                        <img :src="'http://localhost/loterie/' + JSON.parse(item.images)[0]" class="max-w-[125px]">
                        <div class="">
                            <h1 class="font-light">Eveniment:</h1>
                            <h1 class="text">{{ item.title }}</h1>
                        </div>
                        <div>
                            <MazInputNumber @update:model-value="show($event, item.id, index)" :modelValue="item.tickets" label="Bilete" :min="1" />
                        </div>
                        <div>
                            <h1 class="font-light">Pre?? bilet:</h1>
                            <h1>{{ item.price }}&#x20AC;</h1>
                        </div>
                        <div>
                            <h1 class="font-light">De plat?��:</h1>
                            <h1>{{ item.tickets * item.price }}&#x20AC;</h1>
                        </div>

                        <MazBtn color="danger" @click="removeItem(item.id)">Sterge</MazBtn>
                    </div>
                </div>

                <div class="flex justify-end mt-[20px]">
                    <h1 class="text-[20px]">Total de plata:<span class="font-bold ml-[10px]">{{ totalPrice }}&#x20AC</span></h1>
                </div> -->
            <!-- </div> -->
        </div>
    </div>
    <Footer></Footer>
</template>