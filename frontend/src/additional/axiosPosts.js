import axios from "axios"
import { useToast } from "vue-toast-notification"

export const getEvents = async () => {
  const toast = useToast()

  let { data } = await axios
    .post(
      "http://localhost/loterie/getEvents.php",
      {
        getEvents: "1",
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

  let returnValue = null

  if (Array.isArray(data)) {
    returnValue = data
  } else {
    returnValue.push(data)
  }

  return returnValue
}

export const getEventsTickets = async () => {
  let { data } = await axios
    .post(
      "http://localhost/loterie/getEventsTickets.php",
      {
        tickets: "1",
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

  if (data.length === 0) return null

  let returnValue = null

  if (Array.isArray(data)) {
    returnValue = data
  } else {
    returnValue.push(data)
  }

  return returnValue
}
