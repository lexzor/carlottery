<script setup>
import { ref } from 'vue'
import axios from 'axios'
import MazBtn from 'maz-ui/components/MazBtn'
import { useToast } from 'vue-toast-notification';
import { useAccountStore } from '@/stores/account';
import { useRouter } from 'vue-router';

const users = ref([])
const deleting = ref(false)
const toast = useToast()
const container = ref()
const router = useRouter()

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

const editUser = (id) => { router.push({ path: `/adminpanel/utilizatori/edit_user/${id}` }) }

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
        <table class="table-fixed w-full">
            <thead class="text-left">
                <tr class="border-b border-gray-200">
                    <th class="py-4 px-8 border-gray-200 border-r">Utilizator</th>
                    <th class="py-4 px-8 border-gray-200 border-r">E-mail</th>
                    <th class="py-4 px-8 border-gray-200 border-r">Nume de utilizator</th>
                    <th class="py-4 px-8 border-gray-200">Action</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(user, index) in users" :key="index" :id="'userid' + user.id" class="border-b border-gray-200">
                    <td class="py-4 px-8 border-gray-200 border-r">USR-{{ user.id }}</td>
                    <td class="py-4 px-8 border-gray-200 border-r">{{ user.email }}</td>
                    <td class="py-4 px-8 border-gray-200 border-r">{{ user.username }}</td>
                    <td class="py-4 px-8 border-gray-200 flex items-center gap-3">
                        <button @click="editUser(user.id)" class="bg-[#000] text-black rounded-full w-[38px] h-[38px] flex items-center justify-center">
                            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" style="fill: rgba(255, 255, 255, 1);transform: ;msFilter:;"><path d="m16 2.012 3 3L16.713 7.3l-3-3zM4 14v3h3l8.299-8.287-3-3zm0 6h16v2H4z"></path></svg>
                        </button>
                        <button @click="deleteUser(user.id)" class="bg-red-600 text-black rounded-full w-[38px] h-[38px] flex items-center justify-center">
                            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" style="fill: rgba(255, 255, 255, 1);transform: ;msFilter:;"><path d="M5 20a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V8h2V6h-4V4a2 2 0 0 0-2-2H9a2 2 0 0 0-2 2v2H3v2h2zM9 4h6v2H9zM8 8h9v12H7V8z"></path><path d="M9 10h2v8H9zm4 0h2v8h-2z"></path></svg>
                        </button>
                    </td>
                </tr>
            </tbody>
        </table>
        <!-- <h1 class="p-[20px]">User page</h1> 
        <div v-for="(user, index) in users" :key="index" :id="'userid' + user.id" class="flex items-center justify-evenly px-[20px] py-[10px]">
            <div ref="container"></div>  
            <h1>{{ user.id }}</h1>
            <h1>{{ user.email }}</h1>
            <h1>{{ user.upassword }}</h1>
            <h1>{{ user.username }}</h1>
            <MazBtn @click="deleteUser(user.id)" :loading="deleting ? true : false" color="danger">Delete</MazBtn>
            <MazBtn @click="editUser(user.id)">Edit</MazBtn>
        </div> -->
    </div>
</template>