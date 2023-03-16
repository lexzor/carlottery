<script setup>
import { ref } from 'vue'
import axios from 'axios'
import MazBtn from 'maz-ui/components/MazBtn'
import { useToast } from 'vue-toast-notification';
import { useAccountStore } from '@/stores/account';
import { useRouter, useRoute } from 'vue-router'
import router from '../../router';

const users = ref([])
const deleting = ref(false)
const toast = useToast()
const container = ref()

const route = useRoute()


const deleteUser = async id => {
    const account = useAccountStore()
    
    if(id === account.getId())
    {
        toast.open({
            message: "Nu iti poti sterge propriul cont.",
            type: "info",
            duration: 5000
        })

        return
    }

    await axios.post("http://localhost/loterie/delUser.php", {
        id: id
    }, {
        headers: {
            "Content-Type": "application/json"
        }
    }).catch(err => {
        console.error(err)
        
        toast.open({
            message: "Eroare de sistem!",
            type: "error",
            duration: 5000
        })
    }).then(res => {
        if(res.data == 1)
        {
            users.value = users.value.filter(user => user.id !== id)

            toast.open({
                message: "Userul a fost sters cu succes!",
                type: "success",
                duration: 5000
            })
        }
        else 
        {
            toast.open({
                message: "Userul nu a putut fii sters!",
                type: "error",
                duration: 5000
            })
        }
    })
}

const editUser = (id) => {
    router.push({ path: `/adminpanel/utilizatori/edit_user/${id}` })
}

const getUsers = async () => {
    await axios.post("http://localhost/loterie/getUsers.php", {
        getUsers: "1"
    }, {
        headers: {
            'Content-Type': "application/json"
        }
    }).catch(err => {
        console.error(err)

        toast.open({
            message: "Eroare de sistem!",
            type: "error",
            duration: 5000
        })
    }).then(res => {
        users.value = res.data
    })
}

getUsers()

</script>

<template>
    <div>
        <h1 class="p-[20px]">User page</h1> 
        
        <div v-for="(user, index) in users" :key="index" :id="'userid' + user.id" class="flex justify-between items-center px-[20px] py-[10px]">
            <div ref="container"></div>  
            <h1>{{ user.id }}</h1>
            <h1>{{ user.email }}</h1>
            <h1>{{ user.upassword }}</h1>
            <h1>{{ user.username }}</h1>
            <MazBtn @click="deleteUser(user.id)" :loading="deleting ? true : false" color="danger">Delete</MazBtn>
            <MazBtn @click="editUser(user.id)">Edit</MazBtn>
        </div>
    </div>
</template>