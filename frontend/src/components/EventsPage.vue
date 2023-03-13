<script setup>
import axios from 'axios'
import { ref, computed, reactive, onMounted } from 'vue'
import MazInput from 'maz-ui/components/MazInput'
import MazInputNumber from 'maz-ui/components/MazInputNumber'
import MazPicker from 'maz-ui/components/MazPicker'
import MazTextarea from 'maz-ui/components/MazTextArea'
import MazBtn from 'maz-ui/components/MazBtn'
import MazGallery from 'maz-ui/components/MazGallery'
import { initFlowbite } from 'flowbite'
import { useToast } from 'vue-toast-notification'
import { useVuelidate } from '@vuelidate/core'
import { required, minValue } from '@vuelidate/validators'
import { vuelidateTranslator } from '../additional/translator'

const events = ref([])
const files = ref([])
const sending = ref(false)
const toast = useToast()

const state = reactive({
    title: 'Masina 2023',
    description:  'O masina',
    tickets: 17500,
    start: '01-12-1999 17:20',
    end: '01-12-2001 17:20'
})

const rules = {
    title: { required },
    description: { required },
    tickets: { required, minValue: minValue(1) },
    start: { required },
    end: { required }
}

const v = useVuelidate(rules, state)

const getEvents = async () => {
    let { data } = await axios.post('http://localhost/loterie/getEvents.php')

    events.value = data
}

const eventsExists = computed(() => {
    return events.value === null ? false : true
})

const getFiles = computed(() => {
    return files.value
})

const createGallery = computed(() => {
    let gallery = []
    
    files.value.forEach(file => {
        gallery.push(file.previewImage)
    })

    return gallery
})

const getFileName = (filename) => {
    if(filename.length > 33)
    {
        const extension = filename.slice(filename.length - 4, filename.length)
        return filename.slice(0,33) + '...' + extension
    }
    else 
    {
        return filename
    }
}

const submitEvent = async () => {
    sending.value = true
    const result = v.value.$validate()

    if (!result) {
        console.log('test')
        let errorMessage = '<span class="text-[17px]">Nu te poti loga deoarece:</span>'
        let totalErrors = 0

        v.value.$errors.forEach(error => {
            totalErrors++
            errorMessage += "<br>"
            errorMessage += `${totalErrors}. ${vuelidateTranslator(error.$property, error.$message)}`
        })

        toast.open({
            message: `${errorMessage}`,
            type: "error",
            duration: (totalErrors * 6000),
            pauseOnHover: true,
            dismissible: false
        })

        sending.value = false
        return
    }

    let images = []

    files.value.forEach(file => images.push(file.fileObj))

    console.log(images)

    let formData = new FormData()
    formData.append('title', state.title)
    formData.append('description', state.description)
    formData.append('tickets', state.tickets)
    formData.append('start', state.value)
    formData.append('end', state.value)

    if(images.length > 0)
    {
        formData.append('images[]', images)
    }

    let { data } = await axios.post('http://localhost/loterie/addEvent.php', formData, {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
    })

    console.log(data)

    if(data.hasOwnProperty('be_msg'))
    {
        switch(data.be_msg)
        {
            case 'no_images':
                toast.open({
                    message: 'Trebuie incarcata cel putin o imagine',
                    type: "error",
                    duration: 5000,
                    pauseOnHover: true,
                    dismissible: false
                })
            break

            case 'fail_create_main_dir':
                toast.open({
                    message: 'Eroare de sistem:<br>Nu a putut fii creat fisierul <b>event_images</b>',
                    type: "error",
                    duration: 5000,
                    pauseOnHover: true,
                    dismissible: false
                })

            case 'fail_create_event_dir':
                toast.open({
                    message: 'Eroare de sistem:<br>Nu a putut fii creat fisierul <b>event_images/'+ data.dir_name +'</b>',
                    type: "error",
                    duration: 5000,
                    pauseOnHover: true,
                    dismissible: false
                })

            case 'event_dir_exists':
                toast.open({
                    message: 'Eroare de sistem:<br> Fisiserul eventului deja exista.',
                    type: "error",
                    duration: 5000,
                    pauseOnHover: true,
                    dismissible: false
                })
            break

        }
    }

    sending.value = false
}

getEvents()

onMounted(() => {
    initFlowbite()

    const fileInput = document.getElementById('dropzone-file');
    fileInput.onchange = () => {
        const selectedFiles = [...fileInput.files];
        let restrictedFiles = []
        let alreadyExistsingFiles = []

        for(let i = 0; i < selectedFiles.length; i++)
        {
            let file = selectedFiles[i]
        
            if (file.name.indexOf('.jpg') == -1 && file.name.indexOf('.png') == -1) {
                restrictedFiles.push(file.name)
                continue
            }

            let fileFounded = false

            for(let j = 0; j < files.value.length; j++)
            {
                if (files.value[i].fileObj.size === file.size) {
                    alreadyExistsingFiles.push(file.name)
                    fileFounded = true
                    break
                }
            }

            if(fileFounded)
                continue

            files.value.push({
                "fileObj": file,
                "previewImage": URL.createObjectURL(file)
            })
        }

        if(restrictedFiles.length > 0)
        {
            let msg = 'Fisierele urmatoare nu au putut fi<br>incarcate deoarece nu sunt poze:'
            
            restrictedFiles.forEach((file, index) => {
                msg += `<br><b>${index+1}.</b> ${file}`
            })

            toast.open({
                message: msg,
                type: "error",
                duration: 7500,
            })
        }

        if (alreadyExistsingFiles.length > 0) {
            let msg = 'Fisierele urmatoare nu au putut fi<br>incarcate deoarece deja exista:'

            alreadyExistsingFiles.forEach((file, index) => {
                msg += `<br><b>${index + 1}.</b> ${file}`
            })

            toast.open({
                message: msg,
                type: "error",
                duration: 7500,
            })
        }
    }
})

const deleteImage = (imgSize) => {
    files.value = files.value.filter(file => file.fileObj.size !== imgSize)
}

</script>

<template>
    <div class="mt-[50px]">
        <div>
            <form class="flex flex-col max-w-[500px] mx-auto gap-[30px]">
                <h1 class="w-full text-center text-[30px]">Adauga un eveniment</h1>
                <MazInput required auto-focus v-if="v.title.$error" error no-radius label="Titlu" v-model="state.title" />
                <MazInput required auto-focus v-else no-radius label="Titlu" v-model="state.title" />
                <MazTextarea required v-if="v.description.$error" error label="Descriere" v-model="state.description"  />
                <MazTextarea required v-else no-radius label="Descriere" v-model="state.description"  />
                <MazInputNumber required auto-focus v-if="v.tickets.$error" error no-radius label="Numar bilete" v-model="state.tickets"  />
                <MazInputNumber required auto-focus v-else no-radius label="Numar bilete" v-model="state.tickets"  />
                <MazPicker required v-if="v.start.$error" error time format="DD-MM-YYYY HH:mm" locale="ro-RO" no-radius label="Cand incepe" v-model="state.start"  />
                <MazPicker required v-else time format="DD-MM-YYYY HH:mm" locale="ro-RO" no-radius label="Cand incepe" v-model="state.start"  />
                <MazPicker required v-if="v.end.$error" error time format="DD-MM-YYYY HH:mm" locale="ro-RO" no-radius label="Cand se termina" v-model="state.end" />
                <MazPicker required v-else time format="DD-MM-YYYY HH:mm" locale="ro-RO" no-radius label="Cand se termina" v-model="state.end" />

                <div class="relative flex items-center justify-center w-full">
                    <label for="dropzone-file" class="relative flex flex-col items-center justify-center w-full h-64 border-2 border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 dark:hover:bg-bray-800 dark:bg-gray-700 hover:bg-gray-100 dark:border-gray-600 dark:hover:border-gray-500 dark:hover:bg-gray-600">
                        <div class="flex flex-col items-center justify-center pt-5 pb-6">
                            <svg aria-hidden="true" class="w-10 h-10 mb-3 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"></path></svg>
                            <p class="mb-2 text-sm text-gray-500 dark:text-gray-400"><span class="font-semibold">Click to upload</span> or drag and drop</p>
                            <p class="text-xs text-gray-500 dark:text-gray-400">SVG, PNG, JPG or GIF (MAX. 800x400px)</p>
                        </div>
                        <input id="dropzone-file" type="file" name="images" class="absolute top-0 left-0 w-full h-full opacity-0 cursor-pointer" />
                    </label>
                </div>
                
                <div v-if="files.length > 0" class="flex flex-col gap-[20px]">
                    <h1 class="text-[20px]">Galerie imagini</h1>
                    <MazGallery class="p-[10px] bg-black" :images="createGallery" />
                    
                        <div v-if="getFiles.length > 0" v-for="(file, index) in getFiles">
                        <div class="flex gap-[20px]">
                            <MazBtn color="danger" class="min-w-fit" @click="deleteImage(file.fileObj.size)">Delete</MazBtn>
                            <img :src="file.previewImage" class="max-w-[50px] max-h-[50px]">
                            {{getFileName(file.fileObj.name)}}
                        </div>
                    </div>
                </div>


                <MazBtn v-if="!sending" @click="submitEvent" class="bg-black">Adauga eveniment</MazBtn>
                <MazBtn v-else loading class="bg-black">Adauga eveniment</MazBtn>
                
            </form>
        </div>
        <div class="mt-[50px] p-[30px]">
            <div v-if="eventsExists">
                <h1>Events..</h1>
            </div>
            <div v-else>
                <h1 class="w-full text-center text-[19px]">Momentan nu este niciun event activ!</h1>
            </div>
        </div>

    </div>
</template>