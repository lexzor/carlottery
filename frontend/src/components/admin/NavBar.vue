<script setup>
import { ref, watch } from "vue"
import { useRoute } from 'vue-router';

const route = useRoute()

let menu = ref(false)

watch(route, (to, from) => {
    menu.value = false;
})
</script>

<template>
    <div class="bg-[#000] border-b border-[#FFFFFF1A]">
        <div class="mx-auto container px-0">
        <div class="flex justify-between items-center py-4 px-3">
                <div>
                    <router-link tag="h1" class="font-bold text-[25px] flex gap-[15px] text-white" to="/">
                        <span class="text-black bg-[#fff] px-[20px]">CAR</span>
                        <span>SCOR</span>
                    </router-link>
                </div>
                <div class="hidden gap-[66px] text-[#FFFFFF87] text-[18px] xl:flex">
                    <router-link to="/adminpanel/evenimente" class="hover:text-white"
                        active-class="link-underline text-white">Evenimente</router-link>
                    <router-link to="/adminpanel/utilizatori" class="hover:text-white"
                        active-class="link-underline text-white">Utilizatori</router-link>
                    <!-- <router-link to="/adminpanel/castigatori" class="hover:text-white"
                            active-class="link-underline text-white">Câștigători</router-link> -->
                    <router-link to="/adminpanel/comenzi" class="hover:text-white"
                        active-class="link-underline text-white">Comenzi</router-link>
                    <router-link to="/adminpanel/setari-site" class="hover:text-white"
                        active-class="link-underline text-white">Setări</router-link>
                </div>
                <div @click="menu = !menu" class="block xl:hidden cursor-pointer">
                    <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" viewBox="0 0 24 24"
                        style="fill: rgb(255,255,255);transform: ;msFilter:;">
                        <path d="M4 6h16v2H4zm4 5h12v2H8zm5 5h7v2h-7z"></path>
                    </svg>
                </div>
                <Transition name="slide-fade">
                    <div v-if="menu"
                        class="fixed right-0 top-0 w-filt text-white bg-[#000] h-full z-30 flex gap-[15px] flex-col items-left text-[24px] p-[40px]">
                        <div class="flex justify-between items-center gap-[55px] mb-[30px]">
                            <router-link tag="h1" class="font-bold text-[25px] flex gap-[15px] hover:text-black" to="/">
                                <span class="text-black bg-[#fff] px-[20px]">CAR</span>
                                <span class="text-white">SCOR</span>
                            </router-link>
                            <button @click="menu = !menu" class="xl:hidden block">
                                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24"
                                    style="fill: rgba(255,255,255, 1);transform: ;msFilter:;">
                                    <path
                                        d="m16.192 6.344-4.243 4.242-4.242-4.242-1.414 1.414L10.535 12l-4.242 4.242 1.414 1.414 4.242-4.242 4.243 4.242 1.414-1.414L13.364 12l4.242-4.242z">
                                    </path>
                                </svg>
                            </button>
                        </div>

                        <router-link to="/adminpanel/evenimente" class="hover:text-white"
                            active-class="activePage">Evenimente</router-link>
                        <router-link to="/adminpanel/utilizatori" class="hover:text-white"
                            active-class="activePage">Utilizatori</router-link>
                        <router-link to="/adminpanel/castigatori" class="hover:text-white"
                            active-class="activePage">Câștigători</router-link>
                        <router-link to="/adminpanel/comenzi" class="hover:text-white"
                            active-class="activePage">Comenzi</router-link>
                        <router-link to="/adminpanel/setari-site" class="hover:text-white"
                            active-class="activePage">Setări</router-link>
                        <button @click="account.logOut()"
                            class="bg-white text-black text-[16px] px-[42px] py-[11px] mt-[10px]">
                            Delogare
                        </button>
                    </div>
                </Transition>
            </div>
        </div>
    </div>
</template>

<style scoped>
.link-underline {
    position: relative;
}

.link-underline::before {
    content: "";
    position: absolute;
    width: 50%;
    height: 4px;
    bottom: -10px;
    background-color: white;
    left: 50%;
    transform: translateX(-50%);
    border-radius: 20px;
}
</style>