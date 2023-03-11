<script setup>
import '@coreui/coreui/dist/css/coreui.min.css'
import { CCarousel, CCarouselItem } from '@coreui/vue'
</script>

<template>
     <div class="mt-[110px] w-[1420px] min-w-[1435px] mx-auto">
         <CCarousel indicators :interval="false" transition="slide">
             <CCarouselItem class="relative min-w-full max-h-[500px]">
                <div class="relative min-w-full min-h-full">
                    <div class="absolute top-0 left-0 min-w-full min-h-full setBg">das</div>
                    <img src="/porsche.png" class=" top-[-30px] left-0 w-full z-[-1] h-full" alt="slide 1"/>
                </div>
                <div class="absolute top-[100px] left-[100px] z-10 flex flex-col gap-[50px]">
                    <h1 class="text-[30px] text-white uppercase font-bold">Vrei sa fii urmatorul<br>castigator?</h1>
                    <div class="flex flex-nowrap gap-[30px]">
                        <div class="flex w-fit relative gap-[30px]">
                            <router-link to="/register" tag="button" class="text-black bg-white text-[19px] px-[20px] py-[5px] whitespace-nowrap">Inscrie-te</router-link>
                            <router-link to="/register" tag="button" class="absolute bg-transparent z-[-1] right-[-4px] top-[-4px] border-[1px] border-white text-[19px] px-[20px] py-[5px] whitespace-nowrap">Inscrie-te</router-link>
                        </div>
                        <div class="flex w-fit relative gap-[30px]">
                            <router-link to="/register" tag="button" class="text-black bg-white text-[19px] px-[20px] py-[5px] whitespace-nowrap">Vezi biletele</router-link>
                            <router-link to="/register" tag="button" class="absolute bg-transparent z-[-1] right-[-4px] top-[-4px] border-[1px] border-white text-[19px] px-[20px] py-[5px] whitespace-nowrap">Vezi biletele</router-link>
                        </div>
                    </div>
                </div>
            </CCarouselItem>
            <CCarouselItem class="relative min-w-full max-h-[500px]">
                <div class="relative min-w-full min-h-full">
                    <div class="absolute top-0 left-0 min-w-full min-h-full setBg">das</div>
                    <img src="/porsche.png" class=" top-[-30px] left-0 w-full z-[-1] h-full" alt="slide 1"/>
                </div>
                <div class="absolute top-[100px] left-[100px] z-10 flex flex-col gap-[50px]">
                    <h1 class="text-[30px] text-white uppercase font-bold">Vrei sa fii urmatorul castigator?</h1>
                    <div class="flex flex-nowrap gap-[30px]">
                        <div class="flex w-fit relative gap-[30px]">
                            <router-link to="/register" tag="button" class="text-black bg-white text-[19px] px-[20px] py-[5px] whitespace-nowrap">Inscrie-te</router-link>
                            <router-link to="/register" tag="button" class="absolute bg-transparent z-[-1] right-[-4px] top-[-4px] border-[1px] border-white text-[19px] px-[20px] py-[5px] whitespace-nowrap">Inscrie-te</router-link>
                        </div>
                        <div class="flex w-fit relative gap-[30px]">
                            <router-link to="/register" tag="button" class="text-black bg-white text-[19px] px-[20px] py-[5px] whitespace-nowrap">Vezi biletele</router-link>
                            <router-link to="/register" tag="button" class="absolute bg-transparent z-[-1] right-[-4px] top-[-4px] border-[1px] border-white text-[19px] px-[20px] py-[5px] whitespace-nowrap">Vezi biletele</router-link>
                        </div>
                    </div>
                </div>
            </CCarouselItem>
            <CCarouselItem class="relative min-w-full max-h-[500px]">
                <div class="relative min-w-full min-h-full">
                    <div class="absolute top-0 left-0 min-w-full min-h-full setBg">das</div>
                    <img src="/porsche.png" class=" top-[-30px] left-0 w-full z-[-1] h-full" alt="slide 1"/>
                </div>
                <div class="absolute top-[100px] left-[100px] z-10 flex flex-col gap-[50px]">
                    <h1 class="text-[30px] text-white uppercase font-bold">Vrei sa fii urmatorul castigator?</h1>
                    <div class="flex flex-nowrap gap-[30px]">
                        <div class="flex w-fit relative gap-[30px]">
                            <router-link to="/register" tag="button" class="text-black bg-white text-[19px] px-[20px] py-[5px] whitespace-nowrap">Inscrie-te</router-link>
                            <router-link to="/register" tag="button" class="absolute bg-transparent z-[-1] right-[-4px] top-[-4px] border-[1px] border-white text-[19px] px-[20px] py-[5px] whitespace-nowrap">Inscrie-te</router-link>
                        </div>
                        <div class="flex w-fit relative gap-[30px]">
                            <router-link to="/register" tag="button" class="text-black bg-white text-[19px] px-[20px] py-[5px] whitespace-nowrap">Vezi biletele</router-link>
                            <router-link to="/register" tag="button" class="absolute bg-transparent z-[-1] right-[-4px] top-[-4px] border-[1px] border-white text-[19px] px-[20px] py-[5px] whitespace-nowrap">Vezi biletele</router-link>
                        </div>
                    </div>
                </div>
            </CCarouselItem>
            
         </CCarousel>
      </div>
</template>

<style scoped>
.setBg {
    background: rgb(0,0,0);
    background: -moz-linear-gradient(260deg, rgba(0,0,0,0.9220063025210083) 0%, rgba(0,0,0,0.25253851540616246) 100%);
    background: -webkit-linear-gradient(260deg, rgba(0,0,0,0.9220063025210083) 0%, rgba(0,0,0,0.25253851540616246) 100%);
    background: linear-gradient(260deg, rgba(0,0,0,0.9220063025210083) 0%, rgba(0,0,0,0.25253851540616246) 100%);
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#000000",endColorstr="#000000",GradientType=1);
}
</style>