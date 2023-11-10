function chat{
    param(
        [string] $msg
    )
    
    if($msg -eq ""){
        return @{ results="load|chat|""msg""";success=$false }
    }
    Add-Type -AssemblyName Microsoft.VisualBasic
    $Out = [Microsoft.VisualBasic.Interaction]::InputBox($msg, 'IRC')
    return @{ results=$Out;success=$true }
}
