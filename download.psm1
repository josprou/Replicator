Function download{
    param(
            [Parameter(Mandatory)]
            [string] $url,
            [Parameter(Mandatory)]
            [string] $out
        )

    Try{
        Invoke-webrequest -Uri $url -OutFile $out
        Send-Results "Descargado"
    }catch{
        Send-Results "Fallo al descargar"
    }
}
