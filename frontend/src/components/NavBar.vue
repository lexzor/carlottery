<script setup>
import { computed, onMounted } from 'vue'
import { useAccountStore } from '../stores/account'
import { initFlowbite } from 'flowbite'

const account = useAccountStore()

onMounted(() => {
    initFlowbite()
})

const logBtnLink = computed(() => {
    return account.isLogged() == true ? '/account' : '/login'
})

const displayAccBtn = computed(() => {
    return account.isLogged() ? 'flex' : 'hidden'
})
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
                <router-link v-if="!account.isLogged()" :to="logBtnLink" tag="button" class="text-black flex flex-row flex-nowrap items-center gap-[10px]"><font-awesome-icon icon="fa-solid fa-user" class="fa-xl" /></router-link>
                <router-link v-if="!account.isLogged()" to="/register" tag="button" class="text-white bg-[#000000] text-[19px] px-[20px] py-[5px] whitespace-nowrap">Inscrie-te</router-link>
                <router-link v-if="!account.isLogged()" to="/register" tag="button" class="absolute bg-gray-300 z-[-1] right-[-4px] top-[-4px] text-white border-[1px] border-black text-[19px] px-[20px] py-[5px] whitespace-nowrap">Inscrie-te</router-link>
                
                <!-- <div v-if="account.isLogged()"> -->
                    <button :class="displayAccBtn" id="dropdownHoverButton" data-dropdown-toggle="dropdownHover" data-dropdown-trigger="hover" class="text-white bg-[#000000] px-[20px] py-[5px] whitespace-nowrap flex items-center justify-center gap-[10px]" type="button">
                        <font-awesome-icon icon="fa-solid fa-user" class="fa-xl" />
                        <h1  class="text-[19px] h-fit text-center">{{ account.getUsername() }}</h1>
                    </button>
                    <!-- Dropdown menu -->
                    <div id="dropdownHover" :class="displayAccBtn" class="z-10 hidden bg-white divide-y divide-gray-100 rounded-lg shadow w-44 dark:bg-gray-700">
                        <ul class="py-2 text-sm text-gray-700 dark:text-gray-200" aria-labelledby="dropdownDefaultButton">
                            <li v-if="account.isOwner()">
                                <router-link to="/adminpanel/events" tag="a" class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Admin panel</router-link>
                            </li>
                            <li>
                                <a href="#" @click="$event => account.logOut()" class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Log out</a>
                            </li>
                        </ul>
                    </div>
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