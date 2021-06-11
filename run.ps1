function run{
    param(
            [Parameter(Mandatory)]
            [string] $binary,
            [string] $argumentlist,
            [bool] $hidden,
            [int] $sleep=0
    )

    $p=$null

    if($hidden){
        $WindowsStyle='Hidden'
    }else{
        $WindowsStyle='Normal'
    }

    if($argumentlist){
        $p=Start-Process $binary -ArgumentList $argumentlist -WindowStyle $WindowsStyle -Passthru
    }
    else
    {
        $p=Start-Process $binary -WindowStyle $WindowsStyle -Passthru
    }

    if($sleep -gt 0){
        sleep $sleep 
        Stop-Process $p.Id
    }   
}
