<template>
    <div class="container mx-auto mt-[77px]">
        <div class="p-[45px]">
            <h3 class="text-[32px] font-medium text-[#000]">COMPETITII IN DESFASURARE:</h3>
            <p class="text-[24px] text-[#000] font-light mt-[10px]">Vezi toate competitiile sustinute de CarLottery.</p>
            <div class="flex gap-[34px] mt-[44px]">
                <div class="relative boxed-content">
                    <div class="absolute w-full h-full left-0 top-0 z-20">
                        <div class="p-[32px] flex flex-col justify-between h-[85%]">
                            <span class="text-[20px] text-white font-light">Pret tichet: <span class="text-[24px] font-normal">$4,00</span></span>
                            <div class="flex flex-col">
                                <span class="text-[32px] text-white font-medium mb-[10px]">AUDI A8 LI</span>
                                <span class="text-[16px] text-white font-light">Competiția se încheie în</span>
                                <span class="text-[20px] text-white font-normal mt-[-3px]">22 zile, 5 ore și 49 minute</span>
                            </div>
                        </div>
                    </div>
                    <div class="linear-bg z-10"></div>
                    <img class="object-cover w-[484px] h-[407px]" src="../assets/images/a8.webp" alt="Audi A8">
                </div>
                <div class="relative boxed-content">
                    <div class="absolute w-full h-full left-0 top-0 z-20">
                        <div class="p-[32px] flex flex-col justify-between h-[85%]">
                            <span class="text-[20px] text-white font-light">Pret tichet: <span class="text-[24px] font-normal">$4,00</span></span>
                            <div class="flex flex-col">
                                <span class="text-[32px] text-white font-medium mb-[10px]">AUDI A8 LI</span>
                                <span class="text-[16px] text-white font-light">Competiția se încheie în</span>
                                <span class="text-[20px] text-white font-normal mt-[-3px]">22 zile, 5 ore și 49 minute</span>
                            </div>
                        </div>
                    </div>
                    <div class="linear-bg z-10"></div>
                    <img class="object-cover w-[484px] h-[407px]" src="../assets/images/a8.webp" alt="Audi A8">
                </div>
                <div class="relative boxed-content">
                    <div class="absolute w-full h-full left-0 top-0 z-20">
                        <div class="p-[32px] flex flex-col justify-between h-[85%]">
                            <span class="text-[20px] text-white font-light">Pret tichet: <span class="text-[24px] font-normal">$4,00</span></span>
                            <div class="flex flex-col">
                                <span class="text-[32px] text-white font-medium mb-[10px]">AUDI A8 LI</span>
                                <span class="text-[16px] text-white font-light">Competiția se încheie în</span>
                                <span class="text-[20px] text-white font-normal mt-[-3px]">22 zile, 5 ore și 49 minute</span>
                            </div>
                        </div>
                    </div>
                    <div class="linear-bg z-10"></div>
                    <img class="object-cover w-[484px] h-[407px]" src="../assets/images/a8.webp" alt="Audi A8">
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.boxed-content::after {
    content: '';
    position: absolute;
    width: 100%;
    height: 100%;
    border: 1px solid black;
    top: 8px;
    left: 8px;
    z-index: -1;
}
.linear-bg {
    position: absolute;
    width: 100%;
    height: 100%;
    background: linear-gradient(180deg, #000000db 0%, rgba(0, 0, 0, 0) 54.17%, #000000cf 100%);
    left: 0;
    top: 0;
    
}
</style>