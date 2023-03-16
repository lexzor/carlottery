<template>
    <div class="bg-[#000] border-b border-[#FFFFFF1A]">
        <div class="mx-auto container">
            <div class="flex justify-between items-center py-4">
                <div>
                    <router-link tag="h1" class="font-bold text-[25px] flex gap-[15px] text-white" to="/">
                        <span class="text-black bg-[#fff] px-[20px]">CAR</span>
                        <span>LOTERRY</span>
                    </router-link>
                </div>
                <div class="flex gap-[66px] text-[#FFFFFF87] text-[18px]">
                    <router-link to="/adminpanel/evenimente" class="hover:text-white" active-class="link-underline text-white">Evenimente</router-link>
                    <router-link to="/adminpanel/utilizatori" class="hover:text-white" active-class="link-underline text-white">Utilizatori</router-link>
                    <router-link to="/adminpanel/castigatori" class="hover:text-white" active-class="link-underline text-white">Castigatori</router-link>
                    <router-link to="/adminpanel/comenzi" class="hover:text-white" active-class="link-underline text-white">Comenzi</router-link>
                </div>
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