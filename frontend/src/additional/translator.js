export const vuelidateTranslator = (prop, msg, values) => {
  let newMsg = ""
  let newProp = ""

  console.log(prop)

  switch (prop) {
    case "email":
      newProp = "Email"
      break

    case "password":
      newProp = "Parola"
      break

    case "confirmPassword":
      newProp = "Confirmare parola"
      break

    case "username":
      newProp = "Nume de utilizator"
      break

    case "title":
      newProp = "Titlu"
      break

    case "description":
      newProp = "Descriere"
      break

    case "country":
      newProp = "Tara"
      break

    case "address":
      newProp = "Adresa"
      break

    case "firstName":
      newProp = "Nume"
      break

    case "lastName":
      newProp = "Prenume"
      break

    case "zipCode":
      newProp = "Cod Postal"
      break

    case "city":
      newProp = "Oras"
      break

    case "phone":
      newProp = "Teleefon"
      break
  }

  console.log("Message: ", msg)

  switch (msg) {
    case "Value is required":
      newMsg = `Campul <b>${newProp}</b> este obligatoriu`
      break

    case `This field should be at least ${values.minL} characters long`:
      newMsg = `Lungimea valorii campului <b>${newProp}</b> trebuie sa fie minim <b>${values.minL}</b> caractere`
      break

    case `The maximum length allowed is ${values.maxL}`:
      newMsg = `Lungimea valorii campului <b>${newProp}</b> trebuie sa fie maxim <b>${values.minL}</b> caractere`
      break

    case "Value is not a valid email address":
      newMsg = "Valoarea campului <b>Email</b> nu este o adresa valida de email"
      break

    case `The minimum value allowed is ${values.minPriceV}`:
      newMsg = `<b>Pretul</b> nu poate fi mai mic de ${values.minPriceV}E`
      break

    case `The minimum value allowed is ${values.minTicketsV}`:
      newMsg = `<b>Numarul biletelor</b> nu poate fi mai mic de ${values.minTicketsV}`
      break
  }

  return newMsg
}
