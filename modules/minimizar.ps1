function minimizar{
  $x = New-Object -ComObject Shell.Application
  $x.minimizeall() 
  return "Se han minimizado las ventanas"
}
