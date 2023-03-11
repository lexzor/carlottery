import { ref } from "vue"
import { defineStore } from "pinia"

export const useAccountStore = defineStore("account", () => {
  let userid = ref(-1)

  const isLogged = () => {
    return userid > -1 ? true : false
  }

  return { userid, isLogged }
})
