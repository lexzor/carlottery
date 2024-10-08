<script setup>
import { ref, computed, reactive, onMounted } from "vue"
import MazInput from "maz-ui/components/MazInput"
import MazInputNumber from "maz-ui/components/MazInputNumber"
import MazInputPrice from "maz-ui/components/MazInputPrice"
import MazPicker from "maz-ui/components/MazPicker"
// import MazTextarea from "maz-ui/components/MazTextArea"
import MazBtn from "maz-ui/components/MazBtn"
import MazGallery from "maz-ui/components/MazGallery"
import { useRoute, useRouter } from 'vue-router'
import { getEvents } from '../../additional/axiosPosts';
import { useToast } from 'vue-toast-notification';
import { useVuelidate } from "@vuelidate/core"
import { required, minValue } from "@vuelidate/validators"
import axios from "axios"
import { vuelidateTranslator } from "../../additional/translator"
import { QuillEditor } from '@vueup/vue-quill'

const BASE_URL = import.meta.env.VITE_SERVER_BASE_URL

const route = useRoute()
const router = useRouter()
const toast = useToast()
const files = ref([])
const state = reactive({
    title: "",
    description: "",
    max_tickets: 1,
    start: '',
    end: '',
    price: 0,
    images: [],
    winnerText: ''
})

const sending = ref(false)
const deletedImages = ref([])
let eventFolder = ''

const retrieveEvents = async () => {
    const allEvents = await getEvents()
    let existentEvent = null
    if ((existentEvent = allEvents.find(event => event.id === route.params.id)) === undefined) {
        toast.open({
            message: 'Evenimentul nu există!',
            type: "error",
            duration: 5000
        })

        router.push({ path: '/adminpanel/evenimente' })
        return
    }

    existentEvent.price = Number(existentEvent.price)
    existentEvent.max_tickets = Number(existentEvent.max_tickets)
    existentEvent.images = JSON.parse(existentEvent.images)
    Object.assign(state, existentEvent)
    eventFolder = state.images[0].split('/')[1]
}

retrieveEvents()
const rules = {
    title: { required },
    description: { required },
    max_tickets: { required, minValue: minValue(1) },
    start: { required },
    end: { required },
    price: { required, minValue: minValue(0.1) },
}

const v = useVuelidate(rules, state);

const crGallery = computed(() => {
    let gallery = []

    if (state.images.length > 0) {
        state.images.forEach(image => {
            gallery.push(BASE_URL + image)
        })
    }

    if (files.value.length > 0) {
        files.value.forEach(file => {
            gallery.push(file.previewImage)
        })
    }
    return gallery
})

const deleteImage = (delFile, isImgRecent = false) => {
    if (!isImgRecent) {
        deletedImages.value.push(delFile)
        state.images = state.images.filter((file) => file !== delFile)
    }
    else {
        files.value = files.value.filter((file) => file.fileObj.size !== delFile)
    }
}

const getFileName = (filename) => {
    return filename.length > 24
        ? `${filename.slice(0, 24)}...${filename.slice(
            filename.length - 4,
            filename.length
        )}`
        : filename
}

const submitEditEvent = async () => {
    sending.value = true
    const result = await v.value.$validate()

    if (!result) {
        let errorMessage =
            '<span class="text-[17px]">Nu poți adăuga evenimentul deoarece:</span>'
        let totalErrors = 0

        v.value.$errors.forEach((error) => {
            totalErrors++
            errorMessage += "<br>"
            errorMessage += `${totalErrors}. ${vuelidateTranslator(
                error.$property,
                error.$message
            )}`
        })

        if (files.value.length === 0 && state.images.length === 0) {
            errorMessage += `<br>${totalErrors + 1
                }. Trebuie încarcată cel puțin o imagine`
        }

        toast.open({
            message: `${errorMessage}`,
            type: "error",
            duration: totalErrors * 6000,
            pauseOnHover: true,
            dismissible: false,
        })

        sending.value = false
        return
    }

    if (files.value.length === 0 && state.images.length === 0) {
        toast.open({
            message: `<span class="text-[17px]">Nu poți adăuga evenimentul deoarece:</span><br>1. Trebuie incarcata cel putin o imagine!`,
            type: "error",
            duration: 6000,
            pauseOnHover: true,
        })

        sending.value = false
        return
    }

    let images = []

    files.value.forEach((file) => images.push(file.fileObj))

    let formData = new FormData()
    formData.append("id", state.id)
    formData.append("title", state.title)
    formData.append("description", state.description)
    formData.append("max_tickets", state.max_tickets)
    formData.append("start", state.start)
    formData.append("end", state.end)
    formData.append("price", state.price)
    formData.append("imageFolder", eventFolder),
        formData.append("winnerText", state.winnerText)
    deletedImages.value.forEach(image => formData.append("deleteImages[]", image))
    state.images.forEach(image => {
        formData.append("notDeletedImgs[]", image)
    })
    images.forEach((image) => formData.append("images[]", image))

    await axios
        .post(BASE_URL + "updateEvent.php", formData, {
            headers: {
                "Content-Type": "multipart/form-data",
            },
            onUploadProgress: (progressEvent) => {
                if (files.value.length === 0) {
                    return
                }

                let uploadPercentage = parseInt(
                    Math.round((progressEvent.loaded / progressEvent.total) * 100)
                )

                if (uploadPercentage === 100) {
                    toast.open({
                        message: "Imaginile au fost încărcate cu <b>succes</b>!",
                        type: "success",
                        duration: 5000,
                        pauseOnHover: true,
                    })
                }
            },
        })
        .catch((err) => {
            if (err.code) {
                toast.open({
                    message:
                        "Una dintre imagini nu mai există<br>sau i-a fost schimbat numele!",
                    type: "error",
                    duration: 5000,
                    pauseOnHover: true,
                })

                sending.value = false
            }
        }).then(({ data }) => {
            if (data.hasOwnProperty("be_msg_error")) {
                let msg = "Eroare de sistem:"

                switch (data.be_msg) {
                    case "no_images":
                        msg += "<br>Trebuie incarcată cel puțin o imagine"
                        break

                    case "fail_create_main_dir":
                        msg += "<br>Nu a putut fi creat fisierul <b>event_images</b>"
                        break

                    case "uploaded_file_errors":
                        data.errors.forEach((error, index) => {
                            msg += `<br>${index + 1}. ${error}`
                        })
                        break

                    default:
                        msg = "Eroare necunoscută"
                }

                toast.open({
                    message: msg,
                    type: "error",
                    duration: 5000,
                    pauseOnHover: true,
                    dismissible: false,
                })
            } else if (data.hasOwnProperty("be_msg_success")) {
                toast.open({
                    message: "Evenimentul a fost modificat cu success",
                    type: "success",
                    duration: 5000,
                    pauseOnHover: true,
                })
            }
        })



    sending.value = false
}

onMounted(() => {
    const fileInput = document.getElementById("dropzone-file")

    fileInput.onchange = () => {
        const selectedFiles = [...fileInput.files]
        let restrictedFiles = []
        let alreadyExistsingFiles = []
        let sizeExceeded = []

        for (let i = 0; i < selectedFiles.length; i++) {
            let file = selectedFiles[i]

            if (
                file.name.indexOf(".jpg") == -1 &&
                file.name.indexOf(".png") == -1
            ) {
                restrictedFiles.push(file.name)
                continue
            }

            if (file.size > 10485760) {
                sizeExceeded.push(file.name)
                continue
            }

            let fileFounded = false

            for (let j = 0; j < files.value.length; j++) {
                if (files.value[j].fileObj.size === file.size) {
                    alreadyExistsingFiles.push(file.name)
                    fileFounded = true
                    break
                }
            }

            if (fileFounded) {
                continue
            }

            files.value.push({
                fileObj: file,
                previewImage: URL.createObjectURL(file),
            })
        }

        if (restrictedFiles.length > 0) {
            let msg =
                "Fișierele următoare nu au putut fi<br>incărcate deoarece nu sunt poze:"

            restrictedFiles.forEach((file, index) => {
                msg += `<br><b>${index + 1}.</b> ${file}`
            })

            toast.open({
                message: msg,
                type: "error",
                duration: 7500,
            })
        }

        if (restrictedFiles.length > 0) {
            let msg =
                "Fișierele următoare nu au putut fi<br>incărcate deoarece au o dimensiune prea mare:"

            sizeExceeded.forEach((file, index) => {
                msg += `<br><b>${index + 1}.</b> ${file}`
            })

            toast.open({
                message: msg,
                type: "error",
                duration: 7500,
            })
        }

        if (alreadyExistsingFiles.length > 0) {
            let msg =
                "Fișierele următoare nu au putut fi<br>incărcate deoarece deja există:"

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
</script>

<template>
    <div>
        <h1 class="text-center text-[20px] pt-[20px]">Editeaza eveniment <span class="font-bold">[ID: {{ state.id }}]</span>
        </h1>
        <form class="flex flex-col gap-3 max-w-[900px] mx-auto py-[20px]">
            <MazInput required auto-focus no-radius :error="v.title.$error ? true : false" label="Titlu"
                v-model="state.title" />
            <div class="h-fit max-h-[500px] overflow-y-auto">
                <h1 class="text-[19px] font-bold mb-[8px]">Descriere eveniment:</h1>
                <QuillEditor toolbar="full" theme="snow" contentType="html" v-model:content="state.description" />
            </div>
            <div class="h-fit max-h-[500px] overflow-y-auto">
                <h1 class="text-[19px] font-bold mb-[8px]">Text pagină câștigători:</h1>
                <QuillEditor toolbar="full" theme="snow" contentType="html" v-model:content="state.winnerText" />
            </div>
            <div class="flex items-center gap-2">
                <MazInputNumber required class="w-[50%]" auto-focus :error="v.max_tickets.$error ? true : false" no-radius
                    label="Număr bilete" v-model="state.max_tickets" />
                <MazInputPrice no-radius class="w-[50%]" :min="0" locale="ro-RO" currency="EUR" required label="Preț bilet"
                    v-model="state.price" />
            </div>
            <div class="flex gap-2">
                <MazPicker class="w-full" required :error="v.start.$error ? true : false" time format="DD-MM-YYYY HH:mm"
                    locale="ro-RO" no-radius label="Cand incepe" v-model="state.start" />
                <MazPicker class="w-full" required :error="v.end.$error ? true : false" time format="DD-MM-YYYY HH:mm"
                    locale="ro-RO" no-radius label="Când se termină" v-model="state.end" />
            </div>

            <div class="relative flex items-center justify-center w-full">
                <label for="dropzone-file"
                    class="relative flex flex-col items-center justify-center w-full h-34 border-2 border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 dark:hover:bg-bray-800 dark:bg-gray-700 hover:bg-gray-100 dark:border-gray-600 dark:hover:border-gray-500 dark:hover:bg-gray-600">
                    <div class="flex flex-col items-center justify-center pt-5 pb-6">
                        <svg aria-hidden="true" class="w-10 h-10 mb-3 text-gray-400" fill="none" stroke="currentColor"
                            viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12">
                            </path>
                        </svg>
                        <p class="mb-2 text-sm text-gray-500 dark:text-gray-400">
                            <span class="font-semibold">Apasă sau trage</span> o imagine aici
                        </p>
                        <p class="text-xs text-gray-500 dark:text-gray-400">
                            PNG / JPG / WEBP (Mărime maximă: <span class="font-semimbold">10MB</span>)
                        </p>
                    </div>
                    <input id="dropzone-file" multiple type="file" name="images" accept=".jpg, .png, .jpeg, .webp"
                        class="absolute top-0 left-0 w-full h-full opacity-0 cursor-pointer" />
                </label>
            </div>

            <div v-if="state.images.length > 0 || files.length > 0" class="flex flex-col gap-[20px]">
                <h1 class="text-[20px]">Galerie imagini</h1>
                <MazGallery class="p-[10px] bg-black" :images="crGallery" :no-remaining="true" />

                <div v-if="state.images.length > 0" v-for="(file, index) in state.images" :key="index">
                    <div class="flex items-center gap-[20px]">
                        <MazBtn color="danger" class="min-w-fit" @click="deleteImage(file)">Șterge</MazBtn>
                        <img :src="`${BASE_URL + file}`" class="max-w-full max-h-[50px]" />
                        <h1> {{ getFileName(file) }} </h1>
                    </div>
                </div>

                <div v-if="files.length > 0" v-for="(file, index) in files" :key="index">
                    <div class="flex items-center gap-[20px]">
                        <MazBtn color="danger" class="min-w-fit" @click="deleteImage(file.fileObj.size, true)">Șterge
                        </MazBtn>
                        <img :src="file.previewImage" class="max-w-[50px] max-h-[50px]" />
                        {{ getFileName(file.fileObj.name) }}
                    </div>
                </div>
            </div>

            <MazBtn @click="submitEditEvent" :loading="sending ? true : false">Editează evenimentul</MazBtn>

        </form>
    </div>
</template>