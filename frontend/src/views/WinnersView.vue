<script setup>
import { ref } from 'vue';
import NavBar from '../components/NavBar.vue';
import Footer from '../components/Footer.vue';
import LastCompetitions from '../components/LastCompetitions.vue';

const events = ref()

</script>

<template>
    <NavBar />
    <div>
        <LastCompetitions :displayingOnWinnersPage="true" />
    </div>
    <Footer />
</template>