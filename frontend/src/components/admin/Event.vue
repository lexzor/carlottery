<script setup>
  import { toRef, computed, onMounted } from "vue"
  import axios from "axios"
  import MazGallery from "maz-ui/components/MazGallery"
  import { useToast } from "vue-toast-notification"
  import { initModals } from "flowbite"
  import { useRouter } from "vue-router"

  const router = useRouter()

  onMounted(() => {
    initModals()
  })

  const props = defineProps({
    event: {
      type: Object,
      required: true,
    }
  })

  const emit = defineEmits(["deleteEvent"])
  const event = toRef(props, "event")
  const toast = useToast()

  const delEvent = async (id, imgs) => {
    let folderArr = null

    JSON.parse(imgs).forEach((img) => {
      const folderName = img.split("/")[1]

      if (folderArr === null) {
        folderArr = new Array()
      }

      if (folderArr.find((el) => el === folderName) == undefined) {
        folderArr.push(folderName)
      }
    })

    const { data } = await axios
      .post(
        "http://localhost/loterie/delEvent.php",
        {
          id: id,
          imgs: folderArr,
        },
        {
          headers: {
            "Content-Type": "application/json",
          },
        }
      )
      .catch((err) => {
        toast.open({
          message: `O eroare a fost intampinata<br>in timpul stergerii:<br>${err}`,
          type: "error",
          duration: 10000,
        })
      })

    if (data.hasOwnProperty("be_msg_success")) {
      toast.open({
        message: `Evenimentul <b>${event.value.title}</b> a fost sters cu succes!`,
        type: "success",
        duration: 10000,
      })

      emit("deleteEvent", event.value.id)
    } else if (data.hasOwnProperty("be_msg_error")) {
      switch (data.be_msg_error) {
        case "db_conn_error":
          toast.open({
            message: `Eroare la conexiunea bazei de date!`,
            type: "success",
            duration: 10000,
          })
          break

        case "not_deleted":
          toast.open({
            message: `Evenimentul nu mai exista in baza de date!`,
            type: "success",
            duration: 10000,
          })

        case "cant_delete":
          toast.open({
            message: `Folderul ${data.path} nu a putut fii sters!`,
            type: "success",
            duration: 10000,
          })

        case "folder_not_exists":
          toast.open({
            message: `Folderul ${data.path} nu exista!`,
            type: "success",
            duration: 10000,
          })
      }
    } else {
      toast.open({
        message: `Erroare necunoscuta!<br>`,
        type: "error",
        duration: 20000,
      })
    }
  }

  const getEventImages = computed(() => {
    let imagesArray = []

    JSON.parse(event.value.images).forEach((image) => {
      imagesArray.push("http://localhost/loterie/" + image)
    })

    return imagesArray
  })

  const redirectToEditPage = (id) => {
    router.push({path: `/adminpanel/evenimente/edit_event/${id}`})
  }
</script>

<template>
  <div
    :id="'viewPhoto' + event.id"
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
            Vizualizare Imagine
          </h3>
          <button
            id="closeButton"
            :data-modal-hide="'viewPhoto' + event.id"
            class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white"
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
        <div class="p-6 space-y-6">
          <MazGallery :images="getEventImages" />
        </div>
      </div>
    </div>
  </div>
  <tr class="border-b border-gray-200">
    <td class="py-4 px-8 border-gray-200 border-r">EVN-{{ event.id }}</td>
    <td class="py-4 px-8 border-gray-200 border-r">{{ event.title }}</td>
    <td class="py-4 px-8 border-gray-200 border-r">{{ event.max_tickets }}</td>
    <td class="py-4 px-8 border-gray-200 border-r">{{ event.price }} EUR</td>
    <td class="py-4 px-8 border-gray-200 border-r">{{ event.start }}</td>
    <td class="py-4 px-8 border-gray-200 border-r">{{ event.end }}</td>
    <td class="py-4 px-8 border-gray-200 flex items-center gap-3">
      <button
        :data-modal-target="'viewPhoto' + event.id"
        :data-modal-toggle="'viewPhoto' + event.id"
        class="bg-[#000] text-black rounded-full w-[38px] h-[38px] flex items-center justify-center"
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="22"
          height="22"
          viewBox="0 0 24 24"
          style="fill: rgba(255, 255, 255, 1); transform: ; msfilter: "
        >
          <path
            d="M12 9a3.02 3.02 0 0 0-3 3c0 1.642 1.358 3 3 3 1.641 0 3-1.358 3-3 0-1.641-1.359-3-3-3z"
          ></path>
          <path
            d="M12 5c-7.633 0-9.927 6.617-9.948 6.684L1.946 12l.105.316C2.073 12.383 4.367 19 12 19s9.927-6.617 9.948-6.684l.106-.316-.105-.316C21.927 11.617 19.633 5 12 5zm0 12c-5.351 0-7.424-3.846-7.926-5C4.578 10.842 6.652 7 12 7c5.351 0 7.424 3.846 7.926 5-.504 1.158-2.578 5-7.926 5z"
          ></path>
        </svg>
      </button>
      <button class="bg-blue-500 text-white px-[7px] py-[7px] min-h-full" @click="redirectToEditPage(event.id)">
        E
      </button>
      <button
        @click="delEvent(event.id, event.images)"
        class="bg-red-600 text-black rounded-full w-[38px] h-[38px] flex items-center justify-center"
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="22"
          height="22"
          viewBox="0 0 24 24"
          style="fill: rgba(255, 255, 255, 1); transform: ; msfilter: "
        >
          <path
            d="M5 20a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V8h2V6h-4V4a2 2 0 0 0-2-2H9a2 2 0 0 0-2 2v2H3v2h2zM9 4h6v2H9zM8 8h9v12H7V8z"
          ></path>
          <path d="M9 10h2v8H9zm4 0h2v8h-2z"></path>
        </svg>
      </button>
    </td>
  </tr>
</template>
