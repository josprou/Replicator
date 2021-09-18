Function upload{
    param(
            [string] $url,
            [string] $out
         )
    
    if($url -eq "" -or $out -eq ""){
        $global:execute="load|upload|-url <url> -out <out>
        return
    }
    
    Try{
        iwr -Uri $url -OutFile $out -UseBasicParsing
        $global:execute="Subido"
    }Catch [System.Exception] {
        $global:execute="Fallo al subir el fichero"
    }
}
