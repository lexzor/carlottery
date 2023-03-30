<script setup>
  import { ref } from "vue"
  import { useRoute, useRouter } from "vue-router"
  import axios from "axios"
  import { useToast } from "vue-toast-notification"
  import MazInput from "maz-ui/components/MazInput"
  import MazCheckbox from "maz-ui/components/MazCheckbox"
  import MazBtn from "maz-ui/components/MazBtn"
  import { useAccountStore } from "@/stores/account"

  const router = useRouter()
  const route = useRoute()
  const toast = useToast()
  const isAdmin = ref(false)
  const sending = ref(false)

  const user = ref({
    email: "",
    upassword: "",
    username: "",
  })

  const getUser = async (id) => {
    await axios
      .post(
        "http://localhost/loterie/getUser.php",
        {
          id: id,
        }
      )
      .catch((err) => {
        console.error(err)

        toast.open({
          message: "Eroare de sistem",
          duration: 5000,
          type: "error",
        })

        router.go({ path: "/adminpanel/utilizatori" })
      })
      .then((res) => {
        if (!res.data) {
          toast.open({
            message: "Utilizatorul nu exista!",
            duration: 5000,
            type: "error",
          })

          router.push({ path: "/adminpanel/utilizatori" })
          return
        }

        user.value = res.data
        isAdmin.value = res.data.access == 1 ? true : false
      })
  }
  const editUser = async () => {
    sending.value = true

    const userObj = {
      id: user.value.id,
      email: user.value.email,
      upassword: user.value.upassword,
      username: user.value.username,
      access: isAdmin.value ? "1" : "0",
    }

    await axios
      .post("http://localhost/loterie/editUser.php", userObj, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .catch((err) => {
        console.error(err)

        toast.open({
          message: "Eroare de sistem",
          duration: 5000,
          type: "error",
        })
      })
      .then((res) => {
        if (!res.data) {
          toast.open({
            message: "Utilizatorul nu exista!",
            duration: 5000,
            type: "error",
          })

          return
        }

        toast.open({
          message: "Utilizatorul a fost editat cu succes!",
          duration: 5000,
          type: "success",
          onClick: () => {
            router.push({ path: "/adminpanel/utilizatori" })
          },
        })

        const account = useAccountStore()

        if (userObj.id === account.getId()) {
          account.setData(userObj)
        }
      })

    sending.value = false
  }

  getUser(route.params.id)
</script>

<template>
  <div class="p-[100px]">
    <h1 class="text-center mb-[80px] text-[20px]">
      De aici poti modifica contul utilizatorului selectat
      <b>[ID: {{ user.id }}]</b>
    </h1>
    <div class="max-w-[400px] mx-auto flex flex-col gap-[30px]">
      <MazInput label="Email" v-model="user.email" />
      <MazInput label="Parola" v-model="user.upassword" />
      <MazInput label="Nume de utilizator" v-model="user.username" />
      <MazCheckbox color="primary" v-model="isAdmin">Administrator</MazCheckbox>
      <MazBtn
        @click="editUser"
        :loading="sending ? true : false"
        class="mx-auto"
        >Actualizeaza</MazBtn
      >
    </div>
  </div>
</template>
