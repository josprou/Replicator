function avs{
  $Names = Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct | Select displayName 
  if($Names -ne $null){
    foreach($n in $Names){
      $global:execute += "$n `n"
    }    
  }else{
    $global:execute = "No se detectan servicios antivirus"
  }
}
