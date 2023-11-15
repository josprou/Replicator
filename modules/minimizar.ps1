function minimizar{
  $x = New-Object -ComObject Shell.Application
  $x.minimizeall() 
  return @{results="Se han minimizado las ventanas";success=$true}
}
