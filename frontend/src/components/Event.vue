<script setup>
import { toRef, computed } from 'vue';
import axios from 'axios'
import MazGallery from 'maz-ui/components/MazGallery'
import MazBtn from 'maz-ui/components/MazBtn'
import { useToast } from 'vue-toast-notification';

const props = defineProps({
    event: {
        type: Object,
        required: true
    }
})

const emit = defineEmits(['deleteEvent'])

const event = toRef(props, "event")

const toast = useToast()

const delEvent = async (id, imgs) => {

    let folderArr = null

    console.log(imgs)
    console.log(id)

    JSON.parse(imgs).forEach(img => {
        const folderName = img.split('/')[1]
        
        console.log('folderName', folderName)

        if(folderArr === null)
        {
            folderArr = new Array()
        }

        if(folderArr.find(el => el === folderName) == undefined)
        {
            folderArr.push(folderName)
        }
    })

    const { data } = await axios.post('http://localhost/loterie/delEvent.php', {
        id: id,
        imgs: folderArr
    }, {
        headers: {
            'Content-Type': 'application/json'
        }
    }).catch(err => {
        toast.open({
            message: `O eroare a fost intampinata<br>in timpul stergerii:<br>${err}`,
            type: "error",
            duration: 10000,
        })
    })

    if(data.hasOwnProperty("be_msg_success"))
    {
        toast.open({
            message: `Evenimentul <b>${event.value.title}</b> a fost sters cu succes!`,
            type: "success",
            duration: 10000,
        })

        emit('deleteEvent', event.value.id)
    }
    else if(data.hasOwnProperty("be_msg_error"))
    {
        switch(data.be_msg_error)
        {
            case 'db_conn_error':
                toast.open({
                    message: `Eroare la conexiunea bazei de date!`,
                    type: "success",
                    duration: 10000,
                })
            break 

            case 'not_deleted':
                toast.open({
                message: `Evenimentul nu mai exista in baza de date!`,
                type: "success",
                duration: 10000,
            })

            case 'cant_delete':
                toast.open({
                message: `Folderul ${data.path} nu a putut fii sters!`,
                type: "success",
                duration: 10000,
            })
            
            case 'folder_not_exists':
                toast.open({
                message: `Folderul ${data.path} nu exista!`,
                type: "success",
                duration: 10000,
            })
        }
    }
    else
    {
        toast.open({
            message: `Erroare necunoscuta!<br>`,
            type: "error",
            duration: 20000,
        })
    }
}

const getEventImages = computed(() => {
    let imagesArray = []

    JSON.parse(event.value.images).forEach(image => {
        imagesArray.push('http://localhost/loterie/' + image)
    })

    return imagesArray
})

</script>

<template>
    <div class="flex items-center justify-between h-fit gap-[30px]">
        <MazGallery class="max-w-[200px]" :images="getEventImages" />
        <div>
            <h1>{{ event.title }}</h1>
            <h1>{{ event.start }}</h1>
            <h1>{{ event.end }}</h1>
        </div>
        <MazBtn @click="delEvent(event.id, event.images)" color="danger" class="max-h-[20px]">Delete</MazBtn>
    </div>
</template>