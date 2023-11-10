Function upload{
    param(
            [string] $url,
            [string] $out
         )
    
    if($url -eq "" -or $out -eq ""){
        return @{results="load|upload|-url <url> -out <out>";success=$false}
        
    }
    
    Try{
        iwr -Uri $url -OutFile $out -UseBasicParsing
        return  @{results="Fichero subido";success=$true}
    }Catch [System.Exception] {
        return  @{results="Fallo al subir el fichero";success=$false}
    }
}
