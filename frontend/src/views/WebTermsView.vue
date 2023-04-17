<script setup>
import { ref } from 'vue';
import NavBar from '../components/NavBar.vue';
import Footer from '../components/Footer.vue';
import axios from 'axios';
import { getTerms } from '../additional/axiosPosts';

const termsContent = ref()

const retrieveTerms = async () => {
    const data = await getTerms()

    termsContent.value = data
}

retrieveTerms()
</script>

<template>
    <NavBar />
    <div class="container mt-[50px] min-h-[700px]">
        <h1 class="text-[25px]">Termenii si conditiile <b>CarScor</b></h1>
        <div class="py-[20px]" v-html="termsContent">
        </div>
    </div>
    <Footer />
</template>