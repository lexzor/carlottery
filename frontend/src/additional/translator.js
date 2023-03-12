export const vuelidateTranslator = (prop, msg, minL, maxL) => {
  let newMsg = ""
  let newProp = ""

  switch (prop) {
    case "email":
      newProp = "Emailul"
      break

    case "password":
      newProp = "Parola"
      break

    case "confirmPassword":
      newProp = "Confirmarea parolei"
      break

    case "username":
      newProp = "Numele de utilizator"
      break
  }

  switch (msg) {
    case "Value is required":
      newMsg = `<b>${newProp}</b> trebuie completat`
      break

    case `This field should be at least ${minL} characters long`:
      newMsg = `Lungimea valorii campului <b>${newProp}</b> trebuie sa fie minim <b>${minL}</b> caractere`
      break

    case `The maximum length allowed is ${maxL}`:
      newMsg = `Lungimea valorii campului <b>${newProp}</b> trebuie sa fie maxim <b>${minL}</b>  caractere`
      break

    case "Value is not a valid email address":
      newMsg = "Valoarea campului email <b>nu este o adresa valida de email</b>"
      break
  }

  return newMsg
}
