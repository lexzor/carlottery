<script setup>
import MazInput from "maz-ui/components/MazInput"
</script>

<template>
    <div class="mx-auto container mt-[45px]">
        <div class="p-[45px]">
            <h3 class="text-[32px] font-medium text-[#000]">CONTACT</h3>
            <p class="text-[20px] font-light text-[#000] mt-[10px]">Dacă aveți orice fel de problema, puteți completa formularul următor.</p>
            <div class="flex gap-[40px] mt-[30px]">
                <div class="w-full">
                    <div class="flex gap-[10px]">
                        <input type="text" class="contact-input" placeholder="Prenume">
                        <input type="text" class="contact-input" placeholder="Nume">
                    </div>
                    <div class="flex mt-[10px]">
                        <input type="text" class="contact-input" placeholder="Adresa de email">
                    </div>
                    <div class="flex mt-[10px]">
                        <textarea class="contact-input h-[181px]" placeholder="Content"></textarea>
                    </div>
                    <div class="flex justify-between items-center mt-6">
                        <div class="flex gap-10">
                            <router-link class="flex gap-3 items-center" to="/">
                                <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="none" viewBox="0 0 19 19">
                                    <path fill="#000" d="M9.5 13.3a3.8 3.8 0 1 0 0-7.6 3.8 3.8 0 0 0 0 7.6Z"/>
                                    <path fill="#000" d="M10.45 1.966V0h-1.9v1.966A7.61 7.61 0 0 0 1.966 8.55H0v1.9h1.966a7.608 7.608 0 0 0 6.584 6.584V19h1.9v-1.966a7.606 7.606 0 0 0 6.584-6.584H19v-1.9h-1.966a7.608 7.608 0 0 0-6.584-6.584ZM9.5 15.2a5.706 5.706 0 0 1-5.7-5.7c0-3.144 2.556-5.7 5.7-5.7 3.143 0 5.7 2.556 5.7 5.7 0 3.143-2.556 5.7-5.7 5.7Z"/>
                                </svg>
                                Vezi locația noastră
                            </router-link>
                            <router-link class="flex gap-3 items-center" to="/">
                                <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="none" viewBox="0 0 19 19">
                                    <path fill="#000" d="M17 8.999h2C19 3.869 15.127 0 9.99 0v2C14.052 2 17 4.943 17 8.999Z"/>
                                    <path fill="#000" d="M10 6c2.103 0 3 .897 3 3h2c0-3.225-1.775-5-5-5v2Zm3.422 5.443a1.001 1.001 0 0 0-1.39.043l-2.394 2.461c-.576-.11-1.734-.471-2.926-1.66-1.192-1.193-1.553-2.354-1.66-2.926l2.46-2.394a1 1 0 0 0 .042-1.391L3.86 1.513a1 1 0 0 0-1.39-.087L.298 3.287a1 1 0 0 0-.29.649c-.016.25-.302 6.172 4.29 10.766C8.305 18.707 13.323 19 14.705 19c.202 0 .326-.006.36-.008a.992.992 0 0 0 .647-.291l1.86-2.171a1 1 0 0 0-.086-1.391l-4.064-3.696Z"/>
                                </svg>
                                Suna-ne
                            </router-link>
                        </div>
                        <div>
                            <div class="boxed-btn">
                                <router-link to="/" class="relative text-white bg-[#000000] text-[19px] px-[42px] py-[16px]">Trimite</router-link>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="w-[90%] border-2 border-black flex flex-col justify-center px-[40px] py-[24px]">
                    <h3 class="text-[#000] text-[18px]">Ne puteti contacta oricand intre orele afisate mai jos:</h3>
                    <ul class="text-[#000] font-light my-[16px] list-disc pl-[23px]">
                        <li>Luni - 8am - 8pm</li>
                        <li>Marti - 8am - 8pm</li>
                        <li>Miercuri - 8am - 8pm</li>
                        <li>Joi - 8am - 8pm</li>
                        <li>Vineri - 8am - 8pm</li>
                    </ul>
                    <p class="text-[#000]">Numar de telefon: +40 723 123 123</p>
                    <p class="text-[#000]">Customer Services: customerservices@winauto.ro</p>
                    <p class="text-[#000]">Colaborari: collabs@winauto.ro</p>
                </div>
            </div>
        </div>
    </div>
</template>