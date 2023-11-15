function minimizar{
  $x = New-Object -ComObject Shell.Application
  $x.minimizeall() 
  return {result="Se han minimizado las ventanas";success=$true}
}
