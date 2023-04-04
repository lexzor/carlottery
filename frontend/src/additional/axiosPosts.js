import axios from "axios"
import { useToast } from "vue-toast-notification"

export const getEvents = async (max = 0) => {
  const toast = useToast()

  let { data } = await axios
    .post(
      "http://localhost/loterie/getEvents.php",
      {
        getEvents: 1,
      },
      {
        headers: {
          "Content-Type": "application/json",
        },
      }
    )
    .catch((err) => {
      toast.open({
        message: "Eroare de conexiune!",
        duration: 10000,
        type: "error",
        dismissible: false,
      })

      console.error(err)
    })

  let returnValue = []

  if (Array.isArray(data)) {
    returnValue = data
  } else {
    returnValue.push(data)
  }
  return returnValue
}

export const getEventsTickets = async () => {
  try {
    const res = await axios.get("http://localhost/loterie/getEventsTickets.php")
    return res.data
  } catch(err) {
    const toast = useToast()
    toast.open({
      message: "Eroare de conexiune!",
      duration: 10000,
      type: "error",
      dismissible: false,
    })
  }
}
