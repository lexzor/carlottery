<script setup>
  import axios from "axios"
  import { ref, computed, reactive, onMounted } from "vue"
  import MazInput from "maz-ui/components/MazInput"
  import MazInputNumber from "maz-ui/components/MazInputNumber"
  import MazInputPrice from "maz-ui/components/MazInputPrice"
  import MazPicker from "maz-ui/components/MazPicker"
  import MazTextarea from "maz-ui/components/MazTextArea"
  import MazBtn from "maz-ui/components/MazBtn"
  import MazGallery from "maz-ui/components/MazGallery"
  import Event from "./Event.vue"
  import { initFlowbite } from "flowbite"
  import { useToast } from "vue-toast-notification"
  import { useVuelidate } from "@vuelidate/core"
  import { required, minValue } from "@vuelidate/validators"
  import { vuelidateTranslator } from "@/additional/translator"
  import { getEvents } from "@/additional/axiosPosts"

  const events = ref([])
  const files = ref([])
  const sending = ref(false)
  const toast = useToast()

  const waitEvents = async () => {
    events.value = await getEvents()
  }

  waitEvents()

  const getCurrDate = () => {
    const date = new Date().toLocaleDateString("ro-RO")
    const time = new Date().toLocaleTimeString("ro-RO", {
      hour12: false,
      hour: "numeric",
      minute: "numeric",
    })

    return `${date.replaceAll("-", ".")} ${time}`
  }

  const state = reactive({
    title: "",
    description: "",
    max_tickets: 1,
    start: getCurrDate(),
    end: getCurrDate(),
    price: 0,
  })

  const rules = {
    title: { required },
    description: { required },
    max_tickets: { required, minValue: minValue(1) },
    start: { required },
    end: { required },
    price: { required, minValue: minValue(0.0) },
  }

  const v = useVuelidate(rules, state)

  const onDeleteEvent = (id) => {
    events.value = events.value.filter((event) => event.id !== id)
  }

  const eventsExists = computed(() => {
    return events.value === null || events.value.length === 0 ? false : true
  })

  const createGallery = computed(() => {
    let gallery = []

    if (files.value.length > 0) {
      files.value.forEach((file) => {
        gallery.push(file.previewImage)
      })
    }
    return gallery
  })

  const deleteImage = (imgSize) => {
    files.value = files.value.filter((file) => file.fileObj.size !== imgSize)
  }

  const getFileName = (filename) => {
    return filename.length > 33
      ? `${filename.slice(0, 33)}...${filename.slice(
          filename.length - 4,
          filename.length
        )}`
      : filename
  }

  const submitEvent = async () => {
    sending.value = true
    console.log(state.price)
    const result = await v.value.$validate()

    if (!result) {
      let errorMessage =
        '<span class="text-[17px]">Nu poti adauga evenimentul deoarece:</span>'
      let totalErrors = 0

      v.value.$errors.forEach((error) => {
        totalErrors++
        errorMessage += "<br>"
        errorMessage += `${totalErrors}. ${vuelidateTranslator(
          error.$property,
          error.$message
        )}`
      })

      if (files.value.length === 0) {
        errorMessage += `<br>${
          totalErrors + 1
        }. Trebuie incarcata cel putin o imagine`
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

    if (files.value.length === 0) {
      toast.open({
        message: `<span class="text-[17px]">Nu poti adauga evenimentul deoarece:</span><br>1. Trebuie incarcata cel putin o imagine!`,
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
    formData.append("title", state.title)
    formData.append("description", state.description)
    formData.append("max_tickets", state.max_tickets)
    formData.append("start", state.start)
    formData.append("end", state.end)
    formData.append("price", state.price)
    images.forEach((image) => formData.append("images[]", image))

    let { data } = await axios
      .post("http://localhost/loterie/addEvent.php", formData, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
        onUploadProgress: (progressEvent) => {
          let uploadPercentage = parseInt(
            Math.round((progressEvent.loaded / progressEvent.total) * 100)
          )

          if (uploadPercentage === 100) {
            toast.open({
              message: "Imaginile au fost incarcate cu <b>succes</b>!",
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
              "Una dintre imagini nu mai exista<br>sau i-a fost schimba numele!",
            type: "error",
            duration: 5000,
            pauseOnHover: true,
          })

          sending.value = false

          return
        }
      })

    console.log(data)

    if (data.hasOwnProperty("be_msg_error")) {
      let msg = "Eroare de sistem:"

      switch (data.be_msg) {
        case "no_images":
          msg += "<br>Trebuie incarcata cel putin o imagine"
          break

        case "fail_create_main_dir":
          msg += "<br>Nu a putut fii creat fisierul <b>event_images</b>"
          break

        case "uploaded_file_errors":
          data.errors.forEach((error, index) => {
            msg += `<br>${index + 1}. ${error}`
          })
          break

        default:
          msg = "Eroare necunoscuta"
      }

      toast.open({
        message: msg,
        type: "error",
        duration: 5000,
        pauseOnHover: true,
        dismissible: false,
      })
    } else if (data.hasOwnProperty("be_msg_success")) {
      events.value.push({
        id: data.eventId,
        title: state.title,
        description: state.description,
        max_tickets: state.max_tickets,
        start: state.start,
        end: state.end,
        images: data.images,
        price: state.price,
      })

      toast.open({
        message: "Evenimentul a fost adaugat cu success",
        type: "success",
        duration: 5000,
        pauseOnHover: true,
      })

      v.value.$reset()

      state.title = ""
      state.description = ""
      state.max_tickets = 1
      state.start = getCurrDate()
      state.end = getCurrDate()

      files.value = []
    }

    sending.value = false
  }

  onMounted(() => {
    initFlowbite()

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
          "Fisierele urmatoare nu au putut fi<br>incarcate deoarece nu sunt poze:"

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
          "Fisierele urmatoare nu au putut fi<br>incarcate deoarece au o dimensiune prea mare:"

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
          "Fisierele urmatoare nu au putut fi<br>incarcate deoarece deja exista:"

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
  <table v-if="eventsExists" class="table-fixed w-full">
    <thead class="text-left">
      <tr class="border-b border-gray-200">
        <th class="py-4 px-8 border-gray-200 border-r">Eveniment</th>
        <th class="py-4 px-8 border-gray-200 border-r">Titlu</th>
        <th class="py-4 px-8 border-gray-200 border-r">Descriere</th>
        <th class="py-4 px-8 border-gray-200 border-r">Bilete</th>
        <th class="py-4 px-8 border-gray-200 border-r">Pret bilet</th>
        <th class="py-4 px-8 border-gray-200 border-r">Data incepere</th>
        <th class="py-4 px-8 border-gray-200 border-r">Data sfarsit</th>
        <th class="py-4 px-8 border-gray-200">Action</th>
      </tr>
    </thead>
    <tbody>
      <Event
        v-for="(event, index) in events"
        v-on:deleteEvent="onDeleteEvent"
        :key="index"
        :event="event"
      />
    </tbody>
  </table>
  <div v-else class="flex justify-center items-center">
    <p class="p-5">Momentan nu este niciun event activ.</p>
  </div>

  <div
    id="createEventModal"
    data-modal-backdrop="static"
    tabindex="-1"
    aria-hidden="true"
    class="fixed top-0 left-0 right-0 z-50 hidden w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] md:h-full"
  >
    <div class="relative w-full h-full max-w-2xl md:h-auto">
      <!-- Modal content -->
      <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
        <!-- Modal header -->
        <div
          class="flex items-start justify-between p-4 border-b rounded-t dark:border-gray-600"
        >
          <h3 class="text-xl font-semibold text-gray-900 dark:text-white">
            Adauga Eveniment
          </h3>
          <button
            type="button"
            class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white"
            data-modal-hide="createEventModal"
          >
            <svg
              class="w-5 h-5"
              fill="currentColor"
              viewBox="0 0 20 20"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                fill-rule="evenodd"
                d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                clip-rule="evenodd"
              ></path>
            </svg>
          </button>
        </div>
        <!-- Modal body -->
        <div class="p-6 space-y-6">
          <form class="flex flex-col gap-3">
            <MazInput
              required
              auto-focus
              no-radius
              :error="v.title.$error ? true : false"
              label="Titlu"
              v-model="state.title"
            />
            <MazTextarea
              required
              no-radius
              :error="v.description.$error ? true : false"
              label="Descriere"
              v-model="state.description"
            />
            <div class="flex justify-between items-center">
              <MazInputNumber
                required
                auto-focus
                :error="v.max_tickets.$error ? true : false"
                no-radius
                label="Numar bilete"
                v-model="state.max_tickets"
              />
              <MazInputPrice
                no-radius
                :min="0"
                locale="ro-RO"
                currency="EUR"
                required
                label="Pret bilet"
                v-model="state.price"
              />
            </div>
            <div class="flex gap-2">
              <MazPicker
                class="w-full"
                required
                :error="v.start.$error ? true : false"
                time
                format="DD-MM-YYYY HH:mm"
                locale="ro-RO"
                no-radius
                label="Cand incepe"
                v-model="state.start"
              />
              <MazPicker
                class="w-full"
                required
                :error="v.end.$error ? true : false"
                time
                format="DD-MM-YYYY HH:mm"
                locale="ro-RO"
                no-radius
                label="Cand se termina"
                v-model="state.end"
              />
            </div>

            <div class="relative flex items-center justify-center w-full">
              <label
                for="dropzone-file"
                class="relative flex flex-col items-center justify-center w-full h-34 border-2 border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 dark:hover:bg-bray-800 dark:bg-gray-700 hover:bg-gray-100 dark:border-gray-600 dark:hover:border-gray-500 dark:hover:bg-gray-600"
              >
                <div
                  class="flex flex-col items-center justify-center pt-5 pb-6"
                >
                  <svg
                    aria-hidden="true"
                    class="w-10 h-10 mb-3 text-gray-400"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"
                    ></path>
                  </svg>
                  <p class="mb-2 text-sm text-gray-500 dark:text-gray-400">
                    <span class="font-semibold">Click to upload</span> or drag
                    and drop
                  </p>
                  <p class="text-xs text-gray-500 dark:text-gray-400">
                    PNG or JPG (MAX. 800x400px)
                  </p>
                </div>
                <input
                  id="dropzone-file"
                  multiple
                  type="file"
                  name="images"
                  class="absolute top-0 left-0 w-full h-full opacity-0 cursor-pointer"
                />
              </label>
            </div>

            <div v-if="files.length > 0" class="flex flex-col gap-[20px]">
              <h1 class="text-[20px]">Galerie imagini</h1>
              <MazGallery class="p-[10px] bg-black" :images="createGallery" />

              <div
                v-if="files.length > 0"
                v-for="(file, index) in files"
                :key="index"
              >
                <div class="flex gap-[20px]">
                  <MazBtn
                    color="danger"
                    class="min-w-fit"
                    @click="deleteImage(file.fileObj.size)"
                    >Delete</MazBtn
                  >
                  <img
                    :src="file.previewImage"
                    class="max-w-[50px] max-h-[50px]"
                  />
                  {{ getFileName(file.fileObj.name) }}
                </div>
              </div>
            </div>
          </form>
        </div>
        <div
          class="flex items-center p-6 space-x-2 border-t border-gray-200 rounded-b dark:border-gray-600"
        >
          <div>
            <MazBtn v-if="!sending" @click="submitEvent"
              >Adauga eveniment</MazBtn
            >
            <MazBtn v-else loading>Adauga eveniment</MazBtn>
          </div>
          <MazBtn
            data-modal-hide="createEventModal"
            outline
            class="border-black"
            >Anuleaza</MazBtn
          >
        </div>
      </div>
    </div>
  </div>
</template>
