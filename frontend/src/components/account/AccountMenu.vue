<template>
    <div class="min-w-fit flex flex-col gap-[5px]">
        <router-link active-class="activePage" class="text-center px-[20px] py-[7px] hover:bg-black hover:text-white" to="/cont/comenzi">
            <h1>Comenzi</h1>
        </router-link>
        <router-link active-class="activePage" class="text-center px-[20px] py-[7px] hover:bg-black hover:text-white" to="/cont/setari">
            <h1>Setari cont</h1>
        </router-link>
    </div>
</template>

<style scoped>
.activePage {
    color: white;
    background-color: black;
    border-bottom: 1px solid black;
}
</style>