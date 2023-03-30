<script setup>
import NavBar from '../../components/NavBar.vue';
import MazInput from 'maz-ui/components/MazInput'
import MazSelect from "maz-ui/components/MazSelect"
import MazTextarea from "maz-ui/components/MazTextarea"

/*
    await axios.post('http://localhost/loterie/makePayment.php', {
        'quantity': ticketNum.value * currentEvent.value.price,
        'event_id': currentEvent.value.id
    }, {
        headers: {
          "Content-Type": "application/json",
        },
    }).catch(err => console.error).then(({data}) => {
        window.location.href = data
    })
*/

</script>
<template>
        <NavBar />
    <div class="mt-[200px] w-[60%] mx-auto flex flex-col gap-[10px] mb-[200px]">
        <h1 class="uppercase text-center text-[20px] font-bold">Detalii Pentru Facturare</h1>
        <h1>Casutele care sunt notate cu <span class="text-red-600">*</span> sunt obligatorii</h1>
        <div class="flex justify-between gap-[30px] flex-grow-1">
            <MazInput required class="w-full" label="Prenume" no-radius />    
            <MazInput required class="w-full" label="Nume" no-radius />    
        </div>
        <MazInput no-radius label="Nume Companie (Optional)" />
        <MazInput required no-radius label="Nume strada, numar etc." />
        <MazInput no-radius label="Apartament, complex, unitate etc. (optional)" />
        <MazInput required no-radius label="Cod Postal" />
        <MazInput required no-radius label="Oras" />
        <MazInput required no-radius label="Telefon" />
        <MazInput required no-radius label="Adresa email" />
        <h1 class="uppercase text-center text-[20px] font-bold">Informatii Suplimentare</h1>
        <MazTextarea required no-radius label="Note comanda (optional)" id="15" placeholder="Note referitoare la comanda ta, de exemplu: anumite note pentru livrare" />
    </div>
</template>