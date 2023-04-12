import { ref } from "vue"
import { defineStore } from "pinia"
import axios from "axios"
import { useToast } from "vue-toast-notification"
import router from "../router"

const BASE_URL = import.meta.env.VITE_SERVER_BASE_URL

const OWNER_ACCESS = 1
const LOGIN_TIME = 1 // in ore

export const useAccountStore = defineStore("account", () => {
  const uData = ref({})
  const userStore = ref([])

  const internalSaveUserStore = async () => {
    await axios
      .post(
        BASE_URL + "updateCart.php",
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

  const addItemStore = (itemid, tickets, answer) => {
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
      answer: answer,
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

  const getPassword = () => {
    return uData.value.password
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
    const event = new CustomEvent("login_finished")

    if (autoLoginData === null) {
      document.dispatchEvent(event)
      console.error("Auto login object doesn't exists in localstorage")
      return
    }

    const autoLoginDataObj = JSON.parse(autoLoginData)
    const now = new Date()

    if (
      autoLoginDataObj.expiry <= now.getTime() &&
      autoLoginDataObj.expiry != 0
    ) {
      console.error(
        "Auto login object has been deleted from localstorage because the logged in time expired."
      )
      localStorage.removeItem("auto_login")
      document.dispatchEvent(event)
      return
    }

    await axios
      .post(BASE_URL + "authUser.php", {
        login_key: autoLoginDataObj.login_key,
      })
      .then(({ data }) => {
        if (data != -1 && data !== null) {
          uData.value = data

          if (data.cart !== null) {
            userStore.value = data.cart
            delete uData.value.cart
          }

          const newLoginObject = {}

          if (autoLoginDataObj.expiry > 0) {
            Object.assign(newLoginObject, {
              login_key: data.login_key,
              expiry: now.getTime() + LOGIN_TIME * 3600000,
            })
          } else {
            Object.assign(newLoginObject, {
              login_key: data.login_key,
              expiry: 0,
            })
          }

          localStorage.setItem("auto_login", JSON.stringify(newLoginObject))
        } else {
          console.error(
            "Auto login object has been deleted from localstorage in axios request."
          )
          localStorage.removeItem("auto_login")
        }
      })
      .catch((err) => {
        console.error(err)
      })
      .finally(() => {
        document.dispatchEvent(event)
      })
  }

  const loginAcc = (data, permanent) => {
    uData.value = data

    if (data.cart !== null) {
      userStore.value = data.cart
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

  const getSpecificEventTickets = (event_id) => {
    if (!uData.value.hasOwnProperty("id") || uData.value.tickets.length === 0) {
      return 0
    }

    const event = uData.value.tickets.find(
      (ticket) => ticket.event_id == event_id
    )

    return event === undefined ? 0 : event.quantity
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
    getSpecificEventTickets,
    getPassword,
  }
})
