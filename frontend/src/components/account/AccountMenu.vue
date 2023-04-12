<template>
    <div class="xl:w-[400px] w-full shadow-lg bg-white rounded">
        <div class="p-4">
            <h3 class="text-[18px] font-medium text-[#000]">Cont</h3>
            <p class="text-[13px] text-slate-500">Actualizează informațiile contului.</p>
        </div>
        <div class="flex flex-col">
            <router-link to="/cont/setari" active-class="active__tab" class="bg-white px-4 py-3 text-black rounded">Setări
                cont</router-link>
            <router-link to="/cont/comenzi" active-class="active__tab"
                class="bg-white px-4 py-3 text-black rounded">Comenzile tale</router-link>
            <router-link to="/cont/notificari" active-class="active__tab"
                class="bg-white px-4 py-3 text-black rounded">Notificări</router-link>
        </div>
    </div>
</template>

<style scoped>
.activePage {
    color: white;
    background-color: black !important;
    border-bottom: 1px solid black;
}
</style>