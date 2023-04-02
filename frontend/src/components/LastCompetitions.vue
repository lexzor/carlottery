<template>
    <div class="container mx-auto pl-0 mt-[77px]">
        <div class="xl:px-[45px] px-[25px]">
            <h3 class="text-[32px] font-medium text-[#000]">COMPETITII IN DESFASURARE:</h3>
            <p class="text-[24px] text-[#000] font-light mt-[10px]">Vezi toate competitiile sustinute de CarLottery.</p>
<!--            flex xl:flex-row flex-col gap-[34px]-->
            <div class="grid xl:grid-cols-3 grid-cols-1 gap-[34px] mt-[44px]"> 
                <div class="relative h-[400px] bg-cover boxed-content cursor-pointer" @click="goTo(event.hashed_id)" :style="`background-image: url('http://localhost/loterie/${JSON.parse(event.images)[0]}'`" v-for="(event, index) in events" :key="index">
                    <div class="absolute w-full h-full left-0 top-0 z-20">
                        <div class="p-[32px] flex flex-col justify-between h-[85%]">
                            <span class="text-[20px] text-white font-light">Pret tichet: <span class="text-[24px] font-normal">${{ event.price.toLocaleString() }}</span></span>
                            <div class="flex flex-col">
                                <span class="text-[32px] text-white font-medium mb-[10px]">{{ event.title }}</span>
                                <span class="text-[16px] text-white font-light">Competiția se încheie în</span>
                                <span class="text-[20px] text-white font-normal mt-[-3px]">{{ getRemainingTime(event) }}</span>
                            </div>
                        </div>
                    </div>
                    <div class="linear-bg z-10"></div>
                </div>
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
import {getEvents} from "@/additional/axiosPosts";
import { useRouter } from 'vue-router';
import { ref } from 'vue';

const router = useRouter()
let events = ref([]);

const retrieveEvents = async () => {
    events.value = await getEvents()
}

const getRemainingTime = (event) => {
    let remainingTime = Math.floor((formatTimeStamp(event.end) - new Date().getTime()) / 1000);
    console.log(event.end);
    const minutes = Math.floor((remainingTime / 60 ) % 60)
    const hours = Math.floor(((remainingTime / 60) / 60 ) % 24)
    const days = Math.floor(((remainingTime / 60) / 60) / 24)
    return `${days < 10 ? "0" : ""}${days} zile, ${hours < 10 ? "0" : ""}${hours} ore și ${minutes < 10 ? "0" : ""}${minutes} minute`
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