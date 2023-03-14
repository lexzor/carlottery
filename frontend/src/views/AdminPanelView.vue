<script setup>
import { useRoute, useRouter } from 'vue-router'
import { computed, defineAsyncComponent } from 'vue'

const route = useRoute()
const router = useRouter()

const EventsPage = defineAsyncComponent({
    loader: () => import('../components/EventsPage.vue')
})

const UsersPage = defineAsyncComponent( {
    loader: () => import('../components/UsersPage.vue')
})

const getCurrAdminPage = computed(() => {
    switch(route.params.section)
    {
        case 'evenimente':
            return EventsPage

        case 'utilizatiori':
            return UsersPage
            
        default: router.push({ path: '/adminpanel/evenimente' })
    }  
})
</script>

<template>
    <div>
        <div class=" mt-[100px] w-[70%] mx-auto">
            <ul class="w-full flex gap-[30px]">
                <router-link to="/adminpanel/evenimente" tag="li" class="text-[19px] px-[12px] py-[5px]" active-class="activePage">Evenimente</router-link>
                <router-link to="/adminpanel/utilizatiori" tag="li" class="text-[19px] px-[12px] py-[5px]" active-class="activePage">Utilizatori</router-link>
            </ul>
            
            <component :is="getCurrAdminPage"></component>
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