<script setup>
import Navbar from "@/components/Navbar.vue"
import Footer from "@/components/Footer.vue"
import AccountMenu from '@/components/account/AccountMenu.vue'

import { useRoute, useRouter } from 'vue-router'
import { computed, defineAsyncComponent } from 'vue'

import { useAccountStore } from '@/stores/account'

const account = useAccountStore()

const route = useRoute()
const router = useRouter()

setTimeout(() => {
    if (!account.isLogged()) {
        router.push({ path: '/' })
    }
}, 800)

const InvoicesPage = defineAsyncComponent({
    loader: () => import('@/components/account/InvoicesPage.vue')
})
const SettingsPage = defineAsyncComponent({
    loader: () => import('@/components/account/SettingsPage.vue')
})

const getCurrentPage = computed(() => {
    switch (route.params.page) {
        case 'comenzi': return InvoicesPage
            
        case 'setari': return SettingsPage

        default: SettingsPage
    }
})
</script>

<template>
    <Navbar />
    <div class="container mx-auto px-0 mt-[77px]">        
        <div class="xl:px-[45px] px-[25px]">
            <div class="flex xl:flex-row flex-col gap-[25px]">
                <AccountMenu />
                <div class="shadow-lg p-[30px] xl:w-full roudned">
                    <div class="bg-white rounded-[10px] box-shadow">
                        <component :is="getCurrentPage"></component>
                    </div>
                </div>
            </div>
            
            <!-- <AccountMenu />
    
            <div class="shadow-lg p-[30px]">
                <div class="bg-white rounded-[10px] box-shadow">
                    <component :is="getCurrentPage"></component>
                </div>
            </div> -->
        </div>
    </div>
    <Footer />
</template>

<style>
.active__tab {
    background-color: black !important;
    color: white !important;
}
</style>