<script setup>
import { ref } from 'vue';
import axios from 'axios';
import { useAccountStore } from '../../stores/account';

const account = useAccountStore()

const invoices = ref([])

const getInvoices = async () => {
    axios.post('http://localhost/loterie/getInvoicesById.php', {
        "email": account.getEmail()
    }).catch(err => console.error).then(({data}) => {
        invoices.value = data.map(invoice => {
            return { ...invoice, products: JSON.parse(invoice.products)}
        })
    
        console.log(invoices.value)
    })
}
getInvoices()

</script>

<template>
    <div>
        <h1>Aici poti vedea toate comenzile tale</h1>
    </div>
</template>