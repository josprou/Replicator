function chat{
    param(
        [string] $msg
    )
    
    if($msg -eq ""){
        $global:execute="load|chat|""msg"""
        return
    }
    Add-Type -AssemblyName Microsoft.VisualBasic
    $Out = [Microsoft.VisualBasic.Interaction]::InputBox($msg, 'IRC')
    $global:execute=$Out
}
