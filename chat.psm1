function chat{
    param(
        [Parameter(Mandatory)]
        [string] $msg
    )

    Add-Type -AssemblyName Microsoft.VisualBasic
    $Out = [Microsoft.VisualBasic.Interaction]::InputBox($msg, 'IRC')
    $global:execute=$Out
}
