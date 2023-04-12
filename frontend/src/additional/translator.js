export const vuelidateTranslator = (prop, msg, values) => {
  let newMsg = ""
  let newProp = ""

  console.log(prop)

  switch (prop) {
    case "email":
      newProp = "E-mail"
      break

    case "password":
      newProp = "Parolă"
      break

    case "confirmPassword":
      newProp = "Confirmare parolă"
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
      newProp = "Tară"
      break

    case "address":
      newProp = "Adresă"
      break

    case "firstName":
      newProp = "Nume"
      break

    case "lastName":
      newProp = "Prenume"
      break

    case "zipCode":
      newProp = "Cod Poștal"
      break

    case "city":
      newProp = "Oraș"
      break

    case "phone":
      newProp = "Telefon"
      break

    case "currPw":
      newProp = "Parolă actuală"
      break

    case "newPw":
      newProp = "Parolă noua"
      break

    case "confPw":
      newProp = "Confirmare parolă"
      break
  }

  switch (msg) {
    case "Value is required":
      newMsg = `Câmpul <b>${newProp}</b> este obligatoriu`
      break

    case `This field should be at least ${values.minL} characters long`:
      newMsg = `Lungimea valorii câmpului <b>${newProp}</b> trebuie să fie de minim <b>${values.minL}</b> caractere`
      break

    case `The maximum length allowed is ${values.maxL}`:
      newMsg = `Lungimea valorii câmpului <b>${newProp}</b> trebuie să fie de maxim <b>${values.minL}</b> caractere`
      break

    case "Value is not a valid email address":
      newMsg =
        "Valoarea câmpului <b>E-mail</b> nu este o adresă validă de e-mail"
      break

    case `The minimum value allowed is ${values.minPriceV}`:
      newMsg = `<b>Prețul</b> nu poate fi mai mic de ${values.minPriceV}E`
      break

    case `The minimum value allowed is ${values.minTicketsV}`:
      newMsg = `<b>Numărul biletelor</b> nu poate fi mai mic de ${values.minTicketsV}`
      break
  }

  return newMsg
}
