<script setup>
import '@coreui/coreui/dist/css/coreui.min.css'
import { CCarousel, CCarouselItem } from '@coreui/vue'
</script>

<template>
    <div class="container mx-auto px-0 mt-[56px]">
        <div class="xl:px-[45px] px-[25px]">
            <CCarousel indicators :interval="false" transition="slide">
                <CCarouselItem class="relative min-w-full h-[406px]" style="background-image: url('/porsche.png')">
                    <div class="absolute top-0 left-0 min-w-full min-h-full setBg"></div>
                    <div class="flex h-full items-center xl:pl-20 pl-5">
                        <div class="relative z-10 flex flex-col gap-[50px]">
                            <h1 class="text-[40px] text-white uppercase font-medium">Vrei să fii următorul<br>caștigător?</h1>
                            <div class="flex md:flex-row flex-col flex-nowrap xl:gap-[30px] gap-[15px]">
                                <div class="flex w-fit relative gap-[30px]">
                                    <router-link to="/register" tag="button" class="text-black bg-white xl:text-[20px] text-[16px] px-[28px] xl:py-[16px] py-[12px] whitespace-nowrap">Înscrie-te</router-link>
                                    <router-link to="/register" tag="button" class="absolute bg-transparent z-[-1] right-[-4px] top-[-4px] border-[1px] border-white xl:text-[20px] text-[16px] px-[28px] xl:py-[16px] py-[12px] whitespace-nowrap">Înscrie-te</router-link>
                                </div>
                                <div class="flex w-fit relative gap-[30px]">
                                    <router-link to="/evenimente" tag="button" class="text-black bg-white xl:text-[20px] text-[16px] px-[28px] xl:py-[16px] py-[12px] whitespace-nowrap">Vezi competiții</router-link>
                                    <router-link to="/evenimente" tag="button" class="absolute bg-transparent z-[-1] right-[-4px] top-[-4px] border-[1px] border-white xl:text-[20px] text-[16px] px-[28px] xl:py-[16px] py-[12px] whitespace-nowrap">Vezi competiții</router-link>
                                </div>
                            </div>
                        </div>
                    </div>
                </CCarouselItem>
                <CCarouselItem class="relative min-w-full h-[406px]" style="background-image: url('/porsche.png')">
                    <div class="absolute top-0 left-0 min-w-full min-h-full setBg"></div>
                    <div class="flex h-full items-center xl:pl-20 pl-5">
                        <div class="relative z-10 flex flex-col gap-[50px]">
                            <h1 class="text-[40px] text-white uppercase font-medium">Vrei să fii următorul<br>caștigător?</h1>
                            <div class="flex md:flex-row flex-col flex-nowrap xl:gap-[30px] gap-[15px]">
                                <div class="flex w-fit relative gap-[30px]">
                                    <router-link to="/register" tag="button" class="text-black bg-white xl:text-[20px] text-[16px] px-[28px] xl:py-[16px] py-[12px] whitespace-nowrap">Înscrie-te</router-link>
                                    <router-link to="/register" tag="button" class="absolute bg-transparent z-[-1] right-[-4px] top-[-4px] border-[1px] border-white xl:text-[20px] text-[16px] px-[28px] xl:py-[16px] py-[12px] whitespace-nowrap">Înscrie-te</router-link>
                                </div>
                                <div class="flex w-fit relative gap-[30px]">
                                    <router-link to="/evenimente" tag="button" class="text-black bg-white xl:text-[20px] text-[16px] px-[28px] xl:py-[16px] py-[12px] whitespace-nowrap">Vezi competiții</router-link>
                                    <router-link to="/evenimente" tag="button" class="absolute bg-transparent z-[-1] right-[-4px] top-[-4px] border-[1px] border-white xl:text-[20px] text-[16px] px-[28px] xl:py-[16px] py-[12px] whitespace-nowrap">Vezi competiții</router-link>
                                </div>
                            </div>
                        </div>
                    </div>
                </CCarouselItem>
                <CCarouselItem class="relative min-w-full h-[406px]" style="background-image: url('/porsche.png')">
                    <div class="absolute top-0 left-0 min-w-full min-h-full setBg"></div>
                    <div class="flex h-full items-center xl:pl-20 pl-5">
                        <div class="relative z-10 flex flex-col gap-[50px]">
                            <h1 class="text-[40px] text-white uppercase font-medium">Vrei să fii următorul<br>caștigător?</h1>
                            <div class="flex md:flex-row flex-col flex-nowrap xl:gap-[30px] gap-[15px]">
                                <div class="flex w-fit relative gap-[30px]">
                                    <router-link to="/register" tag="button" class="text-black bg-white xl:text-[20px] text-[16px] px-[28px] xl:py-[16px] py-[12px] whitespace-nowrap">Înscrie-te</router-link>
                                    <router-link to="/register" tag="button" class="absolute bg-transparent z-[-1] right-[-4px] top-[-4px] border-[1px] border-white xl:text-[20px] text-[16px] px-[28px] xl:py-[16px] py-[12px] whitespace-nowrap">Înscrie-te</router-link>
                                </div>
                                <div class="flex w-fit relative gap-[30px]">
                                    <router-link to="/evenimente" tag="button" class="text-black bg-white xl:text-[20px] text-[16px] px-[28px] xl:py-[16px] py-[12px] whitespace-nowrap">Vezi competiții</router-link>
                                    <router-link to="/evenimente" tag="button" class="absolute bg-transparent z-[-1] right-[-4px] top-[-4px] border-[1px] border-white xl:text-[20px] text-[16px] px-[28px] xl:py-[16px] py-[12px] whitespace-nowrap">Vezi competiții</router-link>
                                </div>
                            </div>
                        </div>
                    </div>
                </CCarouselItem>
            </CCarousel>
        </div>
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