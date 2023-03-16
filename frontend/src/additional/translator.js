export const vuelidateTranslator = (prop, msg, minL, maxL) => {
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
  }

  switch (msg) {
    case "Value is required":
      newMsg = `Campul <b>${newProp}</b> este obligatoriu`
      break

    case `This field should be at least ${minL} characters long`:
      newMsg = `Lungimea valorii campului <b>${newProp}</b> trebuie sa fie minim <b>${minL}</b> caractere`
      break

    case `The maximum length allowed is ${maxL}`:
      newMsg = `Lungimea valorii campului <b>${newProp}</b> trebuie sa fie maxim <b>${minL}</b> caractere`
      break

    case "Value is not a valid email address":
      newMsg = "Valoarea campului <b>Email</b> nu este o adresa valida de email"
      break
  }

  return newMsg
}
