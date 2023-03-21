import { ref } from "vue"
import { defineStore } from "pinia"
import axios from "axios"
import { useToast } from "vue-toast-notification"
import { useRouter } from "vue-router"

const OWNER_ACCESS = 1

export const useAccountStore = defineStore("account", () => {
  const uData = ref({ ceva: "cacat" })
  const router = useRouter()
  const userStore = ref([])

  const addItemStore = (itemid, tickets) => {
    for (let i = 0; i < userStore.value.length; i++) {
      if (userStore.value[i].eventId == itemid) {
        userStore.value[i].tickets += tickets
        return
      }
    }

    userStore.value.push({
      eventId: itemid,
      tickets: tickets,
    })

    console.log(userStore.value)
  }

  const removeItemStore = (itemid) => {
    userStore.value = userStore.value.filter((item) => item !== itemid)
  }

  const isLogged = () => {
    return uData.value.hasOwnProperty("id")
  }

  const getUsername = () => {
    return uData.value.username
  }

  const getId = () => {
    return uData.value.id
  }

  const logOut = () => {
    uData.value = {}

    if (document.cookie.indexOf("login_key") !== -1) {
      if (document.cookie.length > "login_key=".length + 32) {
        document.cookie = document.cookie.slice(
          "login_key=".length + 32,
          document.cookie.length + 1
        )
      } else {
        document.cookie = "login_key=; Max-Age=-999999"
      }
    }

    const toast = useToast()
    toast.open({
      message: `Ai fost delogat cu succes!`,
      type: "success",
      duration: 3000,
    })

    router.push({ path: "/" })
  }

  const setData = (data) => {
    uData.value = data
  }

  // const setSpecificData = (key, data) => {
  //   if (uData.value.hasOwnProperty(key)) {
  //     uData.value[key] = data
  //   }
  // }

  const isOwner = () => {
    return uData.value.access == OWNER_ACCESS ? true : false
  }

  const autoLogin = async () => {
    if (document.cookie.indexOf("login_key") === -1) {
      return
    }

    const temp = document.cookie.split("login_key=")[1]
    const login_key = temp.length > 32 ? temp.slice(0, 32) : temp

    await axios
      .post("https://carlottery-api.eway-design.com/autoLogin.php", {
        login_key: login_key,
      })
      .then((res) => {
        if (res.data != -1 && res.data !== null) {
          setData(res.data)

          let now = new Date()
          let time = now.getTime()

          time += 3600 * 1000
          now.setTime(time)

          document.cookie = `login_key=${login_key}; expires=${now.toUTCString()}; path=/`
        } else {
          document.cookie = "login_key=; Max-Age=-999999"
          setData({})
          router.push({ path: "/" })
        }
      })
      .catch((err) => {
        console.error(err)
      })
  }

  return {
    isLogged,
    getUsername,
    logOut,
    setData,
    isOwner,
    autoLogin,
    getId,
    addItemStore,
    removeItemStore,
    // setSpecificData,
  }
})
