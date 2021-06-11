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
        iwr -Uri $url -OutFile $out -UseBasicParsing
        $global:execute="Descargado"
    }catch{
        $global:execute="Fallo al descargar"
    }
}
