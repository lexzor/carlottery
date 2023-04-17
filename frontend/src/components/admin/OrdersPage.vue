<script setup>
import { ref } from 'vue';
import axios from 'axios';

const BASE_URL = import.meta.env.VITE_SERVER_BASE_URL
const invoices = ref()

const retrieveInvoices = async () => {
    await axios.post(BASE_URL + 'getInvoicesById.php', {
        email: "allInvoices"
    })
        .catch(err => console.err)
        .then(({ data }) => {
            invoices.value = data
        })
}
retrieveInvoices()
</script>

<template>
    <div>
        <h1>Orders page</h1>
    </div>
</template>