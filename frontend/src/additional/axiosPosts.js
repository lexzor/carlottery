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
  await axios
    .post("http://localhost/loterie/getEventsTickets.php", {
      getEventsTickets: "1",
    })
    .catch((err) => {
      toast.open({
        message: "Eroare de conexiune!",
        duration: 10000,
        type: "error",
        dismissible: false,
      })

      console.error(err)
    })
    .then(({ data }) => {
      if (data.length === 0) return null

      let returnValue = null

      if (Array.isArray(data)) {
        returnValue = data
      } else {
        returnValue.push(data)
      }

      return returnValue
    })
}
