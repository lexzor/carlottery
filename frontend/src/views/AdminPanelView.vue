<script setup>
import Hero from "@/components/admin/Hero.vue"

import { useRoute, useRouter } from 'vue-router'
import { computed, defineAsyncComponent } from 'vue'

import { useAccountStore } from '../stores/account'

const account = useAccountStore()

const route = useRoute()
const router = useRouter()

if (!account.isLogged()) {
    router.push({path: "/"})
}

const EventsPage = defineAsyncComponent({
    loader: () => import('@/components/admin/EventsPage.vue')
})

const UsersPage = defineAsyncComponent( {
    loader: () => import('@/components/admin/UsersPage.vue')
})

const EditUserPage = defineAsyncComponent({
    loader: () => import('@/components/admin/EditUserPage.vue')
})

const getCurrAdminPage = computed(() => {
    switch(route.params.section)
    {
        case 'evenimente':
            return EventsPage

        case 'utilizatori':
            if(route.name === 'edituser')
            {
                return EditUserPage
            }    

            return UsersPage
            
        default: router.push({ path: '/adminpanel/evenimente' })
    }  
})
</script>

<template>
    <Hero hero-title="Dashboard" />
    <div class="mx-auto container">
        <div class="bg-white rounded-[10px] box-shadow">
            <component :is="getCurrAdminPage"></component>
        </div>
    </div>
    
</template>

<style scoped>
.box-shadow {
    box-shadow: 0px 15px 90px -20px rgba(0, 0, 0, 0.2);
}
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