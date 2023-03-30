<script setup>
import MazInput from "maz-ui/components/MazInput"
</script>

<template>
    <div class="mx-auto container mt-[45px]">
        <div class="p-[45px]">
            <h3 class="text-[32px] font-medium text-[#000]">CONTACT</h3>
            <p class="text-[20px] font-light text-[#000] mt-[10px]">Dacă aveți orice fel de problema, puteți completa formularul următor.</p>
            <div class="flex">
                <div class="w-full">
                    <div class="flex gap-[10px]">
                        <MazInput
                            no-radius
                            label="Prenume"
                            class="w-full"
                        />
                        <MazInput
                            no-radius
                            label="Nume"
                            class="w-full"
                        />
                    </div>
                    <MazInput
                        no-radius
                        label="Adresa de e-mail"
                        class="w-full"
                    />
                    <MazInput
                        as="textarea"
                        placeholder="Content"
                        class="w-full textarea-maz"
                        textarea
                    />
                </div>
            </div>
        </div>
    </div>
</template>