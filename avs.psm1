function avs{
  $Names = Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct | Select displayName 
  if($Names -ne $null){
    $global:execute = $Names
  }else{
    $global:execute = "No se detectan servicios antivirus"
  }
}
