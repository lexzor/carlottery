<script setup>
// const Hero = () => import("@/components/admin/Hero.vue")
import Navbar from "@/components/NavBar.vue"
import Hero from "@/components/admin/Hero.vue"
import Footer from "@/components/Footer.vue"

import { useRoute, useRouter } from 'vue-router'
import { computed, defineAsyncComponent } from 'vue'

const route = useRoute()
const router = useRouter()

const EventsPage = defineAsyncComponent({
    loader: () => import('@/components/admin/EventsPage.vue')
})

const UsersPage = defineAsyncComponent( {
    loader: () => import('@/components/admin/UsersPage.vue')
})

const EditUserPage = defineAsyncComponent({
    loader: () => import('@/components/admin/EditUserPage.vue')
})

const EditEventPage = defineAsyncComponent({
    loader: () => import('@/components/admin/EditEventPage.vue')
})

const getCurrAdminPage = computed(() => {
    switch(route.params.section)
    {
        case 'evenimente':
            if(route.name === 'editevent')
            {
                return EditEventPage
            }

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
    <Navbar />
    <Hero />
    <div class="mx-auto px-0 container">
        <div class="px-3">
            <div class="bg-white rounded-[10px] box-shadow">
                <component :is="getCurrAdminPage"></component>
            </div>
        </div>
    </div>
    <Footer />
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