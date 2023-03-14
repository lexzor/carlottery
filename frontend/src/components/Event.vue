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

const emit = defineEmits(['delete'])

const event = toRef(props, "event")

const toast = useToast()

const delEvent = async (id) => {
    const { data } = await axios.post('http://localhost/loterie/delEvent.php', {
        id: id
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
            message: `Evenimentul <b>${event.title}</b> a fost sters cu succes!`,
            type: "success",
            duration: 10000,
        })

        emit('deleteEvent', id)
    }
    else
    {
        toast.open({
            message: `Evenimentul nu mai exista!`,
            type: "error",
            duration: 10000,
        })
    }
}

const getEventImages = computed(() => {
    // return `http://localhost/loterie/${JSON.parse(event.value.images)}`

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
        <MazBtn @click="delEvent(event.id)" color="danger" onDelete="" class="max-h-[20px]">Delete</MazBtn>
    </div>
</template>