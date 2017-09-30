repeat {

  repeat {
    if(liga)
      break
    DTR = false
    enable_recepcao = false
  } until(false)

  repeat {
    if(CD)
      break
    DTR = true
    enable_recepcao = false
  } until(false)

  repeat {
    if(liga == false)
      break
    DTR = true
    enable_recepcao = true
  }

} until(false)
