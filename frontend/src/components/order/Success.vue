<script setup>
import axios from 'axios'
import { useRoute } from 'vue-router'

const route = useRoute()
console.log(route.query.session_id)

axios.get('http://localhost/loterie/storePayment.php')

</script>

<template>
    <div class="container mx-auto mt-[77px]">
        <div class="p-[45px]">
            <div class="bg-white shadow rounded w-full flex justify-center py-10">
                <div class="flex flex-col items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" viewBox="0 0 24 24" style="fill: rgba(26, 184, 73, 1);transform: ;msFilter:;"><path d="M12 2C6.486 2 2 6.486 2 12s4.486 10 10 10 10-4.486 10-10S17.514 2 12 2zm0 18c-4.411 0-8-3.589-8-8s3.589-8 8-8 8 3.589 8 8-3.589 8-8 8z"></path><path d="M9.999 13.587 7.7 11.292l-1.412 1.416 3.713 3.705 6.706-6.706-1.414-1.414z"></path></svg>
                    <h3 class="text-[22px] mt-10 text-[#1ab849] font-medium">Tranzactie finalizata cu succes</h3>
                    <p class="mt-1 text-[#00000094]">Transaction Number: jasdjnjna</p>

                    <p class="text-[18px] mt-6 text-black text-medium">Ai cumparat cu success <b>3 bilete</b> pentru <b>Audi A8L</b></p>
                    <div class="mt-10">
                        <router-link to="/" class="flex items-center gap-2 relative text-white bg-[#000000] text-[19px] px-[22px] py-[16px] whitespace-nowrap"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" style="fill: rgba(255, 255, 255, 1);"><path d="M13.939 4.939 6.879 12l7.06 7.061 2.122-2.122L11.121 12l4.94-4.939z"></path></svg>Inapoi</router-link>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>