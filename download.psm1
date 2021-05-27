Function download{
    param(
            [Parameter(Mandatory)]
            [string] $url,
            [Parameter(Mandatory)]
            [string] $out
        )

    Try{
        Invoke-webrequest -Uri $url -OutFile $out -UseBasicParsing
        Send-Results "Descargado"
    }catch{
        Send-Results "Fallo al descargar"
    }
}
