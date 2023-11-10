function avs{
  $Names = Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct | Select displayName 
  if($Names -ne $null){
    foreach($n in $Names){
      $info += "$($n.displayName) `n"
    }    
  }else{
    $info = "No se detectan servicios antivirus"
  }
  return @{ $results=$info;success=$true }
}
