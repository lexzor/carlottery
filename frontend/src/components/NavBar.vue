<script setup>
import { computed, onMounted, watch, ref } from 'vue'
import { useRoute } from 'vue-router';
import { useAccountStore } from '../stores/account'
import { initFlowbite } from 'flowbite'

const account = useAccountStore()

const route = useRoute()

let menu = ref(false)

watch(route, (to, from) => {
  menu.value = false;
})

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
    <div class="container mx-auto mt-[46px] pl-0">
        <div class="flex justify-between items-center xl:px-[45px] px-[25px]">
            <div class="w-full">
                <router-link tag="h1" class="font-bold text-[25px] flex gap-[15px] hover:text-black" to="/">
                    <span class="text-white bg-[#000000] px-[20px]">WIN</span>
                    <span>AUTO</span>
                </router-link>
            </div>
            <Transition name="slide-fade">
                <div v-if="menu" class="fixed right-0 top-0 w-filt text-white bg-[#000] h-full z-30 flex gap-[15px] flex-col items-left text-[24px] p-[40px]">
                    <div class="flex justify-between items-center gap-[55px] mb-[30px]">
                        <router-link tag="h1" class="font-bold text-[25px] flex gap-[15px] hover:text-black" to="/">
                            <span class="text-black bg-[#fff] px-[20px]">WIN</span>
                            <span class="text-white">AUTO</span>
                        </router-link>
                        <button @click="menu = !menu" class="xl:hidden block">
                            <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" style="fill: rgba(255,255,255, 1);transform: ;msFilter:;"><path d="m16.192 6.344-4.243 4.242-4.242-4.242-1.414 1.414L10.535 12l-4.242 4.242 1.414 1.414 4.242-4.242 4.243 4.242 1.414-1.414L13.364 12l4.242-4.242z"></path></svg>
                        </button>
                    </div>
                    
                    <router-link tag="h1" active-class="activePage" class="hover:text-white" to="/">Acasa</router-link>
                    <router-link tag="h1" active-class="activePage" class="hover:text-white" to="/evenimente">Competitii</router-link>
                    <router-link tag="h1" active-class="activePage" class="hover:text-white" to="/evenimente">Bilete</router-link>
                    <router-link tag="h1" active-class="activePage" class="hover:text-white" to="/evenimente">Castigatori</router-link>

                    <div class="flex items-center relative justify-center gap-[30px] mt-[30px] w-full">
                        <router-link v-if="!account.isLogged()" :to="logBtnLink" tag="button" class="text-white flex flex-row flex-nowrap items-center gap-[10px]"><font-awesome-icon icon="fa-solid fa-user" class="fa-md" /></router-link>
                        <router-link v-if="!account.isLogged()" to="/register" tag="button" class="text-[#000] hover:text-[#000] bg-white text-[19px] px-[20px] py-[5px]">Inscrie-te</router-link>
                        
                        <div :class="displayAccBtn" class="flex items-center gap-[20px]" >
                            <router-link to="/cart" tag="button" >
                                <font-awesome-icon icon="fa-solid fa-cart-shopping" size="md" class="text-white hover:cursor-pointer" />
                            </router-link>
                            <button id="dropdownHoverButton" data-dropdown-toggle="dropdownHover" data-dropdown-trigger="hover" class="text-white bg-[#000000] px-[20px] py-[5px] whitespace-nowrap flex items-center justify-center gap-[10px]" type="button">
                                <font-awesome-icon icon="fa-solid fa-user" class="fa-md" />
                                <h1  class="text-[19px] h-fit text-center">{{ account.getUsername() }}</h1>
                            </button>
                        </div>
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
            </Transition>
            <div class="xl:flex flex-row gap-[50px] text-[20px] font-regular hidden w-full">
                <router-link tag="h1" active-class="activePage" class="px-[15px] whitespace-nowrap hover:text-white hover:bg-black hover:border-b-[1px] hover:border-b-black" to="/">Acasa</router-link>
                <router-link tag="h1" active-class="activePage" class="px-[15px] whitespace-nowrap hover:text-white hover:bg-black hover:border-b-[1px] hover:border-b-black" to="/evenimente">Competitii</router-link>
                <router-link tag="h1" active-class="activePage" class="px-[15px] whitespace-nowrap hover:text-white hover:bg-black hover:border-b-[1px] hover:border-b-black" to="/evenimente">Bilete</router-link>
                <router-link tag="h1" active-class="activePage" class="px-[15px] whitespace-nowrap hover:text-white hover:bg-black hover:border-b-[1px] hover:border-b-black" to="/evenimente">Castigatori</router-link>
            </div>
            <div class="xl:flex items-center relative justify-end gap-[30px] hidden w-full">
                <router-link v-if="!account.isLogged()" :to="logBtnLink" tag="button" class="text-black flex flex-row flex-nowrap items-center gap-[10px]"><font-awesome-icon icon="fa-solid fa-user" class="fa-xl" /></router-link>
                <router-link v-if="!account.isLogged()" to="/register" tag="button" class="text-white bg-[#000000] text-[19px] px-[20px] py-[5px]">Inscrie-te</router-link>
                <router-link v-if="!account.isLogged()" to="/register" tag="button" class="absolute bg-gray-300 z-[-1] right-[-4px] top-[-4px] text-white border-[1px] border-black text-[19px] px-[20px] py-[5px] whitespace-nowrap">Inscrie-te</router-link>
                
                <div :class="displayAccBtn" class="flex items-center gap-[20px]" >
                    <router-link to="/cart" tag="button" >
                        <font-awesome-icon icon="fa-solid fa-cart-shopping" size="lg" class="text-black hover:cursor-pointer" />
                    </router-link>
                    <button id="dropdownHoverButton" data-dropdown-toggle="dropdownHover" data-dropdown-trigger="hover" class="text-white bg-[#000000] px-[20px] py-[5px] whitespace-nowrap flex items-center justify-center gap-[10px]" type="button">
                        <font-awesome-icon icon="fa-solid fa-user" class="fa-xl" />
                        <h1  class="text-[19px] h-fit text-center">{{ account.getUsername() }}</h1>
                    </button>
                </div>
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
            <div>
                <button @click="menu = !menu" class="xl:hidden block">
                    <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" style="fill: rgba(0, 0, 0, 1);transform: ;msFilter:;"><path d="M4 6h16v2H4zm4 5h12v2H8zm5 5h7v2h-7z"></path></svg>
                </button>
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