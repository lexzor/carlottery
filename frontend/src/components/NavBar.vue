<script setup>
import { computed } from 'vue'
import { useAccountStore } from '../stores/account'
   
const account = useAccountStore()

</script>

<template>
    <div class="container mx-auto mt-[46px]">
        <div class="flex justify-between items-center px-[45px]">
            <div>
                <router-link tag="h1" class="font-bold text-[25px] flex gap-[15px] hover:text-black" to="/">
                    <span class="text-white bg-[#000000] px-[20px]">CAR</span>
                    <span>LOTERRY</span>
                </router-link>
            </div>
            <div class="flex flex-row gap-[50px] text-[20px] font-regular">
                <router-link tag="h1" active-class="activePage" class="px-[15px] whitespace-nowrap hover:text-white hover:bg-black hover:border-b-[1px] hover:border-b-black" to="/">Acasa</router-link>
                <router-link tag="h1" active-class="activePage" class="px-[15px] whitespace-nowrap hover:text-white hover:bg-black hover:border-b-[1px] hover:border-b-black" to="/evenimente">Competitii</router-link>
                <router-link tag="h1" active-class="activePage" class="px-[15px] whitespace-nowrap hover:text-white hover:bg-black hover:border-b-[1px] hover:border-b-black" to="/evenimente">Bilete</router-link>
                <router-link tag="h1" active-class="activePage" class="px-[15px] whitespace-nowrap hover:text-white hover:bg-black hover:border-b-[1px] hover:border-b-black" to="/evenimente">Castigatori</router-link>
            </div>
            <div class="flex items-center relative gap-[30px]">
                <router-link to="/login" tag="button" class="text-black"><font-awesome-icon icon="fa-solid fa-user" class="fa-xl" /></router-link>
                <router-link to="/register" tag="button" class="text-white bg-[#000000] text-[19px] px-[20px] py-[5px] whitespace-nowrap">Inscrie-te</router-link>
                <router-link to="/register" tag="button" class="absolute bg-gray-300 z-[-1] right-[-4px] top-[-4px] text-white border-[1px] border-black text-[19px] px-[20px] py-[5px] whitespace-nowrap">Inscrie-te</router-link>
            </div>
        </div>
    </div>
</template>

<style scoped>
.activePage:hover {
    color: white;
    background-color: black;
    border-bottom: 1px solid black;
}
.activePage {
    color: white;
    background-color: black;
    border-bottom: 1px solid black;
}

</style>