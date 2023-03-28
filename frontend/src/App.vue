<script setup>
import { RouterView } from 'vue-router'
// import Footer from './components/Footer.vue'
import { useAccountStore } from './stores/account'

const account = useAccountStore()
account.autoLogin()

</script>

<template>
  <RouterView />
  <!-- <Footer /> -->
</template>

