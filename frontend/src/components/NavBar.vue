<script setup>
import { computed, onMounted, watch, ref } from 'vue'
import { useRoute } from 'vue-router';
import { useAccountStore } from '../stores/account'
import { initFlowbite } from 'flowbite'

const account = useAccountStore()

const route = useRoute()

let menu = ref(false)
let profile = ref(false);

watch(route, (to, from) => {
  menu.value = false;
  profile.value = false;
})

onMounted(() => {
    initFlowbite()
})

const logBtnLink = computed(() => {
    return account.isLogged() == true ? '/account' : '/login'
})
</script>

<template>
    <div class="container mx-auto mt-[46px] px-0 pr-0">
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
                    <router-link tag="h1" active-class="activePage" class="hover:text-white" to="/bilete">Bilete</router-link>
                    <router-link tag="h1" active-class="activePage" class="hover:text-white" to="/evenimente">Castigatori</router-link>

                    <div class="flex items-center relative justify-center gap-[30px] mt-[30px] w-full flex-col">
                        <router-link v-if="!account.isLogged()" :to="logBtnLink" tag="button" class="text-white flex flex-row flex-nowrap items-center gap-[10px]"><font-awesome-icon icon="fa-solid fa-user" class="fa-md" /></router-link>
                        <router-link v-if="!account.isLogged()" to="/register" tag="button" class="text-[#000] hover:text-[#000] bg-white text-[19px] px-[20px] py-[5px]">Inscrie-te</router-link>
                        
                        <div v-if="account.isLogged()" class="flex items-center gap-[20px]" >
                            <router-link to="/cart" tag="button" >
                                <font-awesome-icon icon="fa-solid fa-cart-shopping" class="text-white hover:cursor-pointer" />
                            </router-link>
<!--                            <button id="dropdownAvatarNameButton" data-dropdown-toggle="dropdownAvatarName" class="text-white bg-[#000000] px-[20px] py-[5px] whitespace-nowrap flex items-center justify-center gap-[10px]" type="button">-->
<!--                                <font-awesome-icon icon="fa-solid fa-user" class="fa-md" />-->
<!--                                <h1  class="text-[19px] h-fit text-center">{{ account.getUsername() }}</h1>-->
<!--                            </button>-->

                            <button @click="profile = !profile;" class="bg-[#000] text-white flex items-center gap-[10px] leading-[0px] px-3 py-[6px]">
                                <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" style="fill: rgba(255, 255, 255, 1);transform: ;msFilter:;"><path d="M7.5 6.5C7.5 8.981 9.519 11 12 11s4.5-2.019 4.5-4.5S14.481 2 12 2 7.5 4.019 7.5 6.5zM20 21h1v-1c0-3.859-3.141-7-7-7h-4c-3.86 0-7 3.141-7 7v1h17z"></path></svg>
                                <h1 class="text-[19px] gap-[6px] text-center flex items-center">
                                    <span class="mt-[3px]">{{ account.getUsername() }}</span>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" style="fill: rgba(255, 255, 255, 1);transform: ;msFilter:;"><path d="M16.293 9.293 12 13.586 7.707 9.293l-1.414 1.414L12 16.414l5.707-5.707z"></path></svg>
                                </h1>
                            </button>
                        </div>
                        <div v-if="account.isLogged()" :class="{ 'hidden': !profile }" class="z-10 bg-white divide-y divide-gray-100 rounded-lg shadow w-52 dark:bg-gray-700 dark:divide-gray-600">
                            <div class="px-3 py-3 text-sm text-gray-900 dark:text-white">
                                <div class="font-medium" :title="account.getUsername()">{{ account.getUsername() }}</div>
                                <div class="truncate" :title="account.getEmail()"> {{ account.getEmail() }}</div>
                            </div>
                            <ul class="py-2 text-sm text-gray-700 dark:text-gray-200" aria-labelledby="dropdownInformdropdownAvatarNameButtonationButton">
                                <li>
                                    <a href="#" class="flex items-center gap-[8px] px-3 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white hover:text-black">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" style="fill: rgba(55, 65, 81, 1);transform: ;msFilter:;"><path d="m2.344 15.271 2 3.46a1 1 0 0 0 1.366.365l1.396-.806c.58.457 1.221.832 1.895 1.112V21a1 1 0 0 0 1 1h4a1 1 0 0 0 1-1v-1.598a8.094 8.094 0 0 0 1.895-1.112l1.396.806c.477.275 1.091.11 1.366-.365l2-3.46a1.004 1.004 0 0 0-.365-1.366l-1.372-.793a7.683 7.683 0 0 0-.002-2.224l1.372-.793c.476-.275.641-.89.365-1.366l-2-3.46a1 1 0 0 0-1.366-.365l-1.396.806A8.034 8.034 0 0 0 15 4.598V3a1 1 0 0 0-1-1h-4a1 1 0 0 0-1 1v1.598A8.094 8.094 0 0 0 7.105 5.71L5.71 4.904a.999.999 0 0 0-1.366.365l-2 3.46a1.004 1.004 0 0 0 .365 1.366l1.372.793a7.683 7.683 0 0 0 0 2.224l-1.372.793c-.476.275-.641.89-.365 1.366zM12 8c2.206 0 4 1.794 4 4s-1.794 4-4 4-4-1.794-4-4 1.794-4 4-4z"></path></svg>
                                        <span>Setări</span>
                                    </a>
                                </li>
                                <li>
                                    <router-link to="/cont/comenzi" tag="a" class="flex items-center gap-[8px] px-3 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white hover:text-black">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" style="fill: rgba(55, 65, 81, 1);transform: ;msFilter:;"><path d="M19 3h-2.25a1 1 0 0 0-1-1h-7.5a1 1 0 0 0-1 1H5c-1.103 0-2 .897-2 2v15c0 1.103.897 2 2 2h14c1.103 0 2-.897 2-2V5c0-1.103-.897-2-2-2zm0 17H5V5h2v2h10V5h2v15z"></path></svg>
                                        <span>Comenzi</span>
                                    </router-link>
                                </li>
                            </ul>
                            <ul v-if="account.isOwner()" class="py-2 text-sm text-gray-700 dark:text-gray-200" aria-labelledby="dropdownInformdropdownAvatarNameButtonationButton">
                                <li>
                                    <router-link to="/adminpanel/events" class="flex items-center gap-[8px] px-3 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white hover:text-black">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" style="fill: rgba(55, 65, 81, 1);transform: ;msFilter:;"><path d="M20.995 6.9a.998.998 0 0 0-.548-.795l-8-4a1 1 0 0 0-.895 0l-8 4a1.002 1.002 0 0 0-.547.795c-.011.107-.961 10.767 8.589 15.014a.987.987 0 0 0 .812 0c9.55-4.247 8.6-14.906 8.589-15.014zM12 19.897V12H5.51a15.473 15.473 0 0 1-.544-4.365L12 4.118V12h6.46c-.759 2.74-2.498 5.979-6.46 7.897z"></path></svg>
                                        <span>Zonă Administrativă</span>
                                    </router-link>
                                </li>
                            </ul>
                            <div class="py-2">
                                <a @click="$event => account.logOut()" class="text-[14px] cursor-pointer flex items-center gap-[8px] px-3 py-2 text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white hover:text-black">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" style="fill: rgba(55, 65, 81, 1);transform: ;msFilter:;"><path d="M16 13v-2H7V8l-5 4 5 4v-3z"></path><path d="M20 3h-9c-1.103 0-2 .897-2 2v4h2V5h9v14h-9v-4H9v4c0 1.103.897 2 2 2h9c1.103 0 2-.897 2-2V5c0-1.103-.897-2-2-2z"></path></svg>
                                    <span>Delogare</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </Transition>
            <div class="xl:flex flex-row gap-[50px] text-[20px] font-regular hidden w-full">
                <router-link tag="h1" active-class="activePage" class="px-[15px] whitespace-nowrap hover:text-white hover:bg-black hover:border-b-[1px] hover:border-b-black" to="/">Acasa</router-link>
                <router-link tag="h1" active-class="activePage" class="px-[15px] whitespace-nowrap hover:text-white hover:bg-black hover:border-b-[1px] hover:border-b-black" to="/evenimente">Competitii</router-link>
                <router-link tag="h1" active-class="activePage" class="px-[15px] whitespace-nowrap hover:text-white hover:bg-black hover:border-b-[1px] hover:border-b-black" to="/bilete">Bilete</router-link>
                <router-link tag="h1" active-class="activePage" class="px-[15px] whitespace-nowrap hover:text-white hover:bg-black hover:border-b-[1px] hover:border-b-black" to="/evenimente">Castigatori</router-link>
            </div>
            <div class="xl:flex items-center relative justify-end gap-[30px] hidden w-full">
                <router-link v-if="!account.isLogged()" :to="logBtnLink" tag="button" class="text-black flex flex-row flex-nowrap items-center gap-[10px]"><font-awesome-icon icon="fa-solid fa-user" class="fa-xl" /></router-link>
                <router-link v-if="!account.isLogged()" to="/register" tag="button" class="text-white bg-[#000000] text-[19px] px-[20px] py-[5px]">Inscrie-te</router-link>
                <router-link v-if="!account.isLogged()" to="/register" tag="button" class="absolute bg-gray-300 z-[-1] right-[-4px] top-[-4px] text-white border-[1px] border-black text-[19px] px-[20px] py-[5px] whitespace-nowrap">Inscrie-te</router-link>
                
                <div v-if="account.isLogged()" class="flex items-center gap-[20px]" >
                    <router-link to="/cart" tag="button" >
                        <font-awesome-icon icon="fa-solid fa-cart-shopping" class="text-black hover:cursor-pointer" />
                    </router-link>
                    <button id="dropdownAvatarNameButton" data-dropdown-toggle="dropdownAvatarName" class="bg-[#000] text-white flex items-center gap-[10px] leading-[0px] px-3 py-[6px]">
                        <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" style="fill: rgba(255, 255, 255, 1);transform: ;msFilter:;"><path d="M7.5 6.5C7.5 8.981 9.519 11 12 11s4.5-2.019 4.5-4.5S14.481 2 12 2 7.5 4.019 7.5 6.5zM20 21h1v-1c0-3.859-3.141-7-7-7h-4c-3.86 0-7 3.141-7 7v1h17z"></path></svg>
                        <h1 class="text-[19px] gap-[6px] text-center flex items-center">
                            <span class="mt-[3px]">{{ account.getUsername() }}</span>
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" style="fill: rgba(255, 255, 255, 1);transform: ;msFilter:;"><path d="M16.293 9.293 12 13.586 7.707 9.293l-1.414 1.414L12 16.414l5.707-5.707z"></path></svg>
                        </h1>
                    </button>
                </div>
                <div v-if="account.isLogged()" id="dropdownAvatarName" class="z-10 hidden bg-white divide-y divide-gray-100 rounded-lg shadow w-52 dark:bg-gray-700 dark:divide-gray-600">
                    <div class="px-3 py-3 text-sm text-gray-900 dark:text-white">
                        <div class="font-medium text-[16px]" :title="account.getUsername()">{{ account.getUsername() }}</div>
                        <div class="truncate" :title="account.getEmail()">{{ account.getEmail() }}</div>
                    </div>
                    <ul class="py-2 text-sm text-gray-700 dark:text-gray-200" aria-labelledby="dropdownInformdropdownAvatarNameButtonationButton">
                        <li>
                            <a href="#" class="flex items-center gap-[8px] px-3 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white hover:text-black">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" style="fill: rgba(55, 65, 81, 1);transform: ;msFilter:;"><path d="m2.344 15.271 2 3.46a1 1 0 0 0 1.366.365l1.396-.806c.58.457 1.221.832 1.895 1.112V21a1 1 0 0 0 1 1h4a1 1 0 0 0 1-1v-1.598a8.094 8.094 0 0 0 1.895-1.112l1.396.806c.477.275 1.091.11 1.366-.365l2-3.46a1.004 1.004 0 0 0-.365-1.366l-1.372-.793a7.683 7.683 0 0 0-.002-2.224l1.372-.793c.476-.275.641-.89.365-1.366l-2-3.46a1 1 0 0 0-1.366-.365l-1.396.806A8.034 8.034 0 0 0 15 4.598V3a1 1 0 0 0-1-1h-4a1 1 0 0 0-1 1v1.598A8.094 8.094 0 0 0 7.105 5.71L5.71 4.904a.999.999 0 0 0-1.366.365l-2 3.46a1.004 1.004 0 0 0 .365 1.366l1.372.793a7.683 7.683 0 0 0 0 2.224l-1.372.793c-.476.275-.641.89-.365 1.366zM12 8c2.206 0 4 1.794 4 4s-1.794 4-4 4-4-1.794-4-4 1.794-4 4-4z"></path></svg>
                                <span>Setări</span>
                            </a>
                        </li>
                        <li>
                            <router-link to="/cont/comenzi" tag="a" class="flex items-center gap-[8px] px-3 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white hover:text-black">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" style="fill: rgba(55, 65, 81, 1);transform: ;msFilter:;"><path d="M19 3h-2.25a1 1 0 0 0-1-1h-7.5a1 1 0 0 0-1 1H5c-1.103 0-2 .897-2 2v15c0 1.103.897 2 2 2h14c1.103 0 2-.897 2-2V5c0-1.103-.897-2-2-2zm0 17H5V5h2v2h10V5h2v15z"></path></svg>
                                <span>Comenzi</span>
                            </router-link>
                        </li>
                    </ul>
                    <ul v-if="account.isOwner()" class="py-2 text-sm text-gray-700 dark:text-gray-200" aria-labelledby="dropdownInformdropdownAvatarNameButtonationButton">
                        <li>
                            <router-link to="/adminpanel/events" class="flex items-center gap-[8px] px-3 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white hover:text-black">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" style="fill: rgba(55, 65, 81, 1);transform: ;msFilter:;"><path d="M20.995 6.9a.998.998 0 0 0-.548-.795l-8-4a1 1 0 0 0-.895 0l-8 4a1.002 1.002 0 0 0-.547.795c-.011.107-.961 10.767 8.589 15.014a.987.987 0 0 0 .812 0c9.55-4.247 8.6-14.906 8.589-15.014zM12 19.897V12H5.51a15.473 15.473 0 0 1-.544-4.365L12 4.118V12h6.46c-.759 2.74-2.498 5.979-6.46 7.897z"></path></svg>
                                <span>Zonă Administrativă</span>
                            </router-link>
                        </li>
                    </ul>
                    <div class="py-2">
                        <a @click="$event => account.logOut()" class="text-[14px] text-gray-700 cursor-pointer flex items-center gap-[8px] px-3 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white hover:text-black">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" style="fill: rgba(55, 65, 81, 1);transform: ;msFilter:;"><path d="M16 13v-2H7V8l-5 4 5 4v-3z"></path><path d="M20 3h-9c-1.103 0-2 .897-2 2v4h2V5h9v14h-9v-4H9v4c0 1.103.897 2 2 2h9c1.103 0 2-.897 2-2V5c0-1.103-.897-2-2-2z"></path></svg>
                            <span>Delogare</span>
                        </a>
                    </div>
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