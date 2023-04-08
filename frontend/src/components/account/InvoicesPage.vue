<script setup>
import { ref } from 'vue';
import axios from 'axios';
import { useAccountStore } from '../../stores/account';
import DataTable from 'datatables.net-vue3';
import Select from 'datatables.net-select'

const account = useAccountStore()

const invoices = ref([])

let loading = ref(false)

const getInvoices = async () => {
    axios.post('http://localhost/loterie/getInvoicesById.php', {
        "email": account.getEmail()
    }).catch(err => console.error).then(({data}) => {
        loading.value = true
        console.log(data)
        invoices.value = data.map(invoice => {
            return { ...invoice, products: JSON.parse(invoice.products)}
        })
    
        console.log(invoices.value)
    })
}
getInvoices()

DataTable.use(Select)
</script>

<template>
    <div class="flex justify-center" v-if="!loading">
        <div class="flex items-center mt-[30px] gap-3">
            <font-awesome-icon class="text-[36px] rotate text-[#000]" icon="fa-solid fa-spinner" />
            <h3 class="text-[20px] text-[#000]">Loading...</h3>
        </div>
    </div>
    <div v-else>
        <DataTable
        class="display"
        :data="invoices"
        :columns="[
            { data: 'id' },
            { data: 'firstName' },
            { data: 'lastName' }
                ]">
            <thead>
                <tr>
                    <th>NR. Factura</th>
                    <th>Nume</th>
                    <th>Prenume</th>
                </tr>
            </thead>
        </DataTable>
    </div>
</template>