<script setup>
import NavBar from '../components/NavBar.vue'
import Carousel from '../components/Carousel.vue'
import LastCompetitions from '../components/LastCompetitions.vue'
import Contact from '../components/Contact.vue'
import Footer from '../components/Footer.vue'
</script>

<template>
	<NavBar />
	<div>
		<Carousel />
		<LastCompetitions :displayingOnHomePage="true" />
		<Contact />
		<Footer />
	</div>
</template>
