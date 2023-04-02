import { ref } from "vue"
import { defineStore } from "pinia"
import axios from "axios"
import { useToast } from "vue-toast-notification"
import { useRouter } from "vue-router"

const OWNER_ACCESS = 1
const LOGIN_TIME = 1 // in ore

export const useAccountStore = defineStore("account", () => {
  const uData = ref({})
  const router = useRouter()
  const userStore = ref([])

  const internalSaveUserStore = async () => {
    await axios
      .post(
        "http://localhost/loterie/updateCart.php",
        {
          id: uData.value.id,
          cart:
            userStore.value.length > 0
              ? JSON.stringify(userStore.value)
              : "NULL",
        },
        {
          headers: {
            "Content-Type": "application/json",
          },
        }
      )
      .catch((err) => console.err)
  }

  const addItemStore = (itemid, tickets) => {
    for (let i = 0; i < userStore.value.length; i++) {
      if (userStore.value[i].id == itemid) {
        userStore.value[i].tickets += tickets
        internalSaveUserStore()
        return
      }
    }

    userStore.value.push({
      id: itemid,
      tickets: tickets,
    })

    internalSaveUserStore()
  }

  const removeItemStore = (itemid) => {
    userStore.value = userStore.value.filter((item) => item.id !== itemid)
    internalSaveUserStore()
  }

  const getStore = () => {
    return userStore.value
  }

  const isLogged = () => {
    return uData.value.hasOwnProperty("id")
  }

  const getUsername = () => {
    return uData.value.username
  }

  const getEmail = () => {
    return uData.value.email
  }

  const getId = () => {
    return uData.value.id
  }

  const isOwner = () => {
    return uData.value.access == OWNER_ACCESS ? true : false
  }

  const logOut = () => {
    uData.value = {}

    localStorage.removeItem("auto_login")

    const toast = useToast()
    toast.open({
      message: `Ai fost delogat cu succes!`,
      type: "success",
      duration: 3000,
    })

    router.push({ path: "/" })
  }

  const autoLogin = async () => {
    const autoLoginData = localStorage.getItem("auto_login")

    if (autoLoginData === null) {
      return
    }

    const autoLoginDataObj = JSON.parse(autoLoginData)
    const now = new Date()

    if (
      autoLoginDataObj.expiry < now.getTime() &&
      autoLoginDataObj.expiry !== 0
    ) {
      localStorage.removeItem("auto_login")
      return
    }

    await axios
      .post("http://localhost/loterie/autoLogin.php", {
        login_key: autoLoginDataObj.login_key,
      })
      .then((res) => {
        if (res.data != -1 && res.data !== null) {
          uData.value = res.data

          if (res.data.cart !== null) {
            userStore.value = JSON.parse(res.data.cart)
          }

          if (autoLoginDataObj.expiry > 0) {
            localStorage.setItem(
              "auto_login",
              JSON.stringify({
                login_key: res.data.login_key,
                expiry: now.getTime() + LOGIN_TIME * 3600000,
              })
            )
          }
        } else {
          localStorage.removeItem("auto_login")
        }
      })
      .catch((err) => {
        console.error(err)
      })
  }

  const loginAcc = (data, permanent) => {
    uData.value = data

    if (data.cart !== null) {
      userStore.value = JSON.parse(data.cart)
    }

    let expireTime = 0

    if (permanent) {
      expireTime = 0
    } else {
      const date = new Date()
      expireTime = date.getTime() + LOGIN_TIME * 3600000
    }

    localStorage.setItem(
      "auto_login",
      JSON.stringify({
        login_key: data.login_key,
        expiry: expireTime,
      })
    )
  }

  return {
    isLogged,
    getUsername,
    getEmail,
    logOut,
    isOwner,
    autoLogin,
    getId,
    addItemStore,
    removeItemStore,
    getStore,
    loginAcc,
  }
})
