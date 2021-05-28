Function download{
    param(
            [string] $url,
            [string] $out
        )
    
    if($url -eq "" -or $out -eq ""){
        $global:execute="load|download|-url <url> -out <out>
        return
    }
    
    Try{
        Invoke-webrequest -Uri $url -OutFile $out -UseBasicParsing
        Send-Results "Descargado"
    }catch{
        Send-Results "Fallo al descargar"
    }
}
