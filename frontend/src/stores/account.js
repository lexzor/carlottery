import { ref } from "vue"
import { defineStore } from "pinia"

const OWNER_ACCESS = 1

export const useAccountStore = defineStore("account", () => {
  const uData = ref({ ceva: "cacat" })

  const isLogged = () => {
    return uData.value.hasOwnProperty("id")
  }

  const getUsername = () => {
    return uData.value.username
  }

  const logOut = () => {
    uData.value = {}
  }

  const setData = (data) => {
    uData.value = data
    console.log(uData.value)
  }

  const isOwner = () => {
    return uData.value.access == OWNER_ACCESS ? true : false
  }

  return {
    isLogged,
    getUsername,
    logOut,
    setData,
    isOwner,
  }
})
