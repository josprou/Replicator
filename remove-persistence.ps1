function Remove-Persistence{
  reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /v "OneDriveUpdate" /f
}
