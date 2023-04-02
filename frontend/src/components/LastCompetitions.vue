<template>
    <div class="container mx-auto pl-0 mt-[77px]">
        <div v-if="!displayingOnHomePage" class="flex gap-[20px] xl:px-[45px] px-[25px]">
            <button @click="currentView = true" :class="currentView == true ? 'text-white bg-black' : ''" class="px-[20px] py-[10px] hover:text-white hover:bg-black">In desfasurare</button>
            <button @click="currentView = false" :class="currentView == false ? 'text-white bg-black' : ''" class="px-[20px] py-[10px] hover:text-white hover:bg-black">Terminate</button>
        </div>
        <div v-if="currentView || displayingOnHomePage" class="xl:px-[45px] px-[25px]">
            <h3 class="text-[32px] font-medium text-[#000] mt-[40px]">COMPETITII IN DESFASURARE:</h3>
            <p class="text-[24px] text-[#000] font-light mt-[10px]">Vezi toate competitiile sustinute de CarLottery.</p>
<!--            flex xl:flex-row flex-col gap-[34px]-->
            <div v-if="events.onGoing.length > 0" class="grid xl:grid-cols-3 grid-cols-1 gap-[34px] mt-[44px]"> 
                <div class="relative h-[400px] bg-cover boxed-content cursor-pointer" @click="goTo(event.hashed_id)" :style="`background-image: url('http://localhost/loterie/${JSON.parse(event.images)[0]}'`" v-for="(event, index) in events.onGoing" :key="event.id">
                    <div class="absolute w-full h-full left-0 top-0 z-20">
                        <div class="p-[32px] flex flex-col justify-between h-[85%]">
                            <span class="text-[20px] text-white font-light">Pret tichet: <span class="text-[24px] font-normal">${{ event.price.toLocaleString() }}</span></span>
                            <div class="flex flex-col">
                                <span class="text-[32px] text-white font-medium mb-[10px]">{{ event.title }}</span>
                                <span class="text-[16px] text-white font-light">Competi?›ia se Ã®ncheie Ã®n</span>
                                <span class="text-[20px] text-white font-normal mt-[-3px]">{{ formatTemplateTime(event.remainingTime) }}</span>
                            </div>
                        </div>
                    </div>
                    <div class="linear-bg z-10"></div>
                </div>
            </div>
            <div v-else>
                <h3 class="text-[27px] text-center mt-[70px] mb-[100px] font-medium text-[#000]">Momentan nu avem nicio competitie in desfasurare!</h3>
            </div>
            <div class="flex justify-center mt-[62px]">
                <div class="boxed-btn">
                    <router-link to="/" tag="button" class="relative text-white bg-[#000000] text-[19px] px-[42px] py-[16px] whitespace-nowrap">Mai multe</router-link>
                </div>
            </div>
        </div>
        <div v-else class="xl:px-[45px] px-[25px]">
            <h3 class="text-[32px] font-medium text-[#000] mt-[40px]">COMPETITIILE TERMINATE:</h3>
                <p class="text-[24px] text-[#000] font-light mt-[10px]">Vezi toate competitiile sustinute de CarLottery.</p>
    <!--            flex xl:flex-row flex-col gap-[34px]-->
                <div v-if="events.finished.length > 0" class="grid xl:grid-cols-3 grid-cols-1 gap-[34px] mt-[44px]"> 
                    <div class="relative h-[400px] bg-cover boxed-content cursor-pointer" @click="goTo(event.hashed_id)" :style="`background-image: url('http://localhost/loterie/${JSON.parse(event.images)[0]}'`" v-for="(event, index) in events.finished" :key="event.id">
                        <div class="absolute w-full h-full left-0 top-0 z-20">
                            <div class="p-[32px] flex flex-col justify-between h-[85%]">
                                <span class="text-[20px] text-white font-light">Pret tichet: <span class="text-[24px] font-normal">${{ event.price.toLocaleString() }}</span></span>
                                <div class="flex flex-col">
                                    <span class="text-[32px] text-white font-medium mb-[10px]">{{ event.title }}</span>
                                    <span class="text-[16px] text-white font-light">Competit&#807ie Ã®ncheita&#774</span>
                                </div>
                            </div>
                        </div>
                        <div class="linear-bg z-10"></div>
                    </div>
                </div>
                <div v-else>
                    <h3 class="text-[27px] text-center mt-[70px] mb-[100px] font-medium text-[#000]">Momentan nu avem nicio competitie incheiata!</h3>
                </div>
                <div class="flex justify-center mt-[62px]">
                    <div class="boxed-btn">
                        <router-link to="/" tag="button" class="relative text-white bg-[#000000] text-[19px] px-[42px] py-[16px] whitespace-nowrap">Mai multe</router-link>
                    </div>
                </div>
        </div>
    </div>
</template>
<script setup>
import { getEvents } from "@/additional/axiosPosts";
import { useRouter } from 'vue-router';
import { ref } from 'vue';

const currentView = ref(true)
const router = useRouter()
const events = ref({
    onGoing: [],
    finished: []
});

const props = defineProps({
    displayingOnHomePage: {
        type: Boolean,
        required: false
    }
})

const retrieveEvents = async () => {
    const allEvents = await getEvents()

    allEvents.forEach( event => {
        event['remainingTime'] = getRemainingTime(event)

        if(event.remainingTime.seconds > 0)
        {
            console.log('ongoing', event)
            events.value.onGoing.push(event)
        }
        else 
        {
            console.log('finished', event)
            events.value.finished.push(event)
        }
    })
}

const getRemainingTime = (event) => {
    const remainingTime = Math.floor((formatTimeStamp(event.end) - new Date().getTime()) / 1000);
    const seconds = Math.floor(remainingTime % 60)
    const minutes = Math.floor((remainingTime / 60 ) % 60)
    const hours = Math.floor(((remainingTime / 60) / 60 ) % 24)
    const days = Math.floor(((remainingTime / 60) / 60) / 24)
    return {days, hours, minutes, seconds}
}

const formatTemplateTime = (remainingTime) => {
    return `${remainingTime.days < 10 ? "0" : ""}${remainingTime.days} zile, ${remainingTime.hours < 10 ? "0" : ""}${remainingTime.hours} ore, ${remainingTime.minutes < 10 ? "0" : ""}${remainingTime.minutes} minute ™i ${remainingTime.seconds < 10 ? "0" : ""}${remainingTime.seconds}`
}

const formatTimeStamp = (time) => {
    const evDate = time.split(' ')
    const splittedDate = evDate[0].split('-')
    const correctlyFormatedDate = `${splittedDate[1]}/${splittedDate[0]}/${splittedDate[2]} ${evDate[1]}:00`
    return Date.parse(correctlyFormatedDate)
}

const goTo = (hashed_id) => {
    router.push({path: `/evenimente/${hashed_id}`})
}

retrieveEvents();
</script>

<style scoped>
.competitions {
    display: grid;
    gap: 34px;
    grid-template-columns: repeat(3, calc(100% / 3));
}

.boxed-content::after {
    content: '';
    position: absolute;
    width: 100%;
    height: 100%;
    border: 1px solid black;
    top: 8px;
    left: 8px;
    z-index: -1;
}

.boxed-btn {
    position: relative;
}
.boxed-btn a::after {
    content: '';
    position: absolute;
    width: 100%;
    height: 100%;
    border: 1px solid black;
    left: 4px;
    bottom: 4px;
}
.linear-bg {
    position: absolute;
    width: 100%;
    height: 100%;
    background: linear-gradient(180deg, #000000db 0%, rgba(0, 0, 0, 0) 54.17%, #000000cf 100%);
    left: 0;
    top: 0;
    
}
</style>