$RegKey='HKCU:\Control Panel\Desktop\'
(New-Object System.Net.Webclient).DownloadString('https://raw.githubusercontent.com/josprou/Replicator/main/fondo.jpg') > $Env:SystemDrive\Users\$Env:USERNAME\AppData\Local\Microsoft\fondo.jpg
Set-ItemProperty -Path $RegKey -Name 'Wallpaper' -Value "$Env:SystemDrive\Users\$Env:USERNAME\AppData\Local\Microsoft\fondo.jpg"
