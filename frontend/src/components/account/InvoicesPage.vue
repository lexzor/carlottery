<script setup>
import { ref } from 'vue';
import axios from 'axios';
import { useAccountStore } from '../../stores/account';

const BASE_URL = import.meta.env.VITE_SERVER_BASE_URL

const account = useAccountStore()

const invoices = ref([])

let loading = ref(false)

const getInvoices = async () => {
    axios.post(BASE_URL + 'getInvoicesById.php', {
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
</script>

<template>
    <div class="flex justify-center" v-if="!loading">
        <div class="flex items-center mt-[30px] gap-3">
            <font-awesome-icon class="text-[36px] rotate text-[#000]" icon="fa-solid fa-spinner" />
            <h3 class="text-[20px] text-[#000]">Loading...</h3>
        </div>
    </div>
    <div v-else>
        <div class="relative overflow-x-auto m-[-30px] rounded-sm">
            <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                <tr>
                    <th scope="col" class="px-6 py-3">
                        INV-ID
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Nume
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Prenume
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Status
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Data scandenței
                    </th>
                </tr>
                </thead>
                <tbody>
                    <tr v-for="invoice in invoices" class="bg-white border-b dark:bg-gray-900 dark:border-gray-700">
                        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                            INV-{{ invoice.id }}
                        </th>
                        <td class="px-6 py-4">
                            {{ invoice.firstName }}
                        </td>
                        <td class="px-6 py-4">
                            {{ invoice.lastName }}
                        </td>
                        <td class="px-6 py-4">
                            {{ invoice.paymentStatus == 'paid' ? "Plătită" : "Neplătită" }}
                        </td>
                        <td class="px-6 py-4">
                            {{ invoice.createdAt }}
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>