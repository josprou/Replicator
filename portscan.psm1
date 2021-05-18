function portscan{
    param([String]$Hosts)

    $hostList = New-Object System.Collections.ArrayList

    function Parse-Hosts{
        Param([Parameter(Mandatory = $True)] [String] $Hosts)
        
        [String[]] $iHosts = $Hosts.Split(",")
        foreach($iHost in $iHosts){
            $iHost = $iHost.Replace(" ", "")
            if(!$iHost){
                continue
            }
            if($iHost.contains("/")){
                $netPart = $iHost.split("/")[0]
                [uint32]$maskPart = $iHost.split("/")[1]
                $address = [System.Net.IPAddress]::Parse($netPart)
                if ($maskPart -ge $address.GetAddressBytes().Length * 8){
                    throw "Bad host mask"
                }
                $numhosts = [System.math]::Pow(2,(($address.GetAddressBytes().Length *8) - $maskPart))
                $startaddress = $address.GetAddressBytes()
                [array]::Reverse($startaddress)
                $startaddress = [System.BitConverter]::ToUInt32($startaddress, 0)
                [uint32]$startMask = ([System.math]::Pow(2, $maskPart)-1) * ([System.Math]::Pow(2,(32 - $maskPart)))
                $startAddress = $startAddress -band $startMask
                $startAddress = [System.BitConverter]::GetBytes($startaddress)[0..3]
                [array]::Reverse($startaddress)
                $address = [System.Net.IPAddress] [byte[]] $startAddress
                $hostList.Add($address.IPAddressToString)
                for ($i=0; $i -lt $numhosts-1; $i++){
                    $nextAddress =  $address.GetAddressBytes()
                    [array]::Reverse($nextAddress)
                    $nextAddress =  [System.BitConverter]::ToUInt32($nextAddress, 0)
                    $nextAddress ++
                    $nextAddress = [System.BitConverter]::GetBytes($nextAddress)[0..3]
                    [array]::Reverse($nextAddress)
                    $address = [System.Net.IPAddress] [byte[]] $nextAddress
                    $hostList.Add($address.IPAddressToString)
                }
            }else{
                $hostList.Add($iHost)
            }
        }
    }
    Parse-Hosts -Hosts $Hosts
    $hostList
}
