function users{
    $UserList= @()
    $NetUser = (net user)
    $results += $NetUser | Out-String
    $LineCount = ($NetUser | Measure).Count
    $Count = $LineCount-3
    do {
        $LineList = $NetUser[$Count].split(' ')
        $UserList += $LineList -ne ""
        $Count -= 1
    }while ($Count -gt 3)
    $UserList
    $usuarios = Get-LocalUser  | ForEach-Object  Name
    $results += $usuarios | Out-String
    for ($counter = 0; $counter -lt $usuarios.Count;$counter++){
        if(-not ($UserList -contains $usuarios[$counter])){
            $UserList += $usuarios[$counter]
        }
   }
   $usuarios = ls C:/Users  | ForEach-Object  Name
   $results += $usuarios | Out-String
   for ($counter = 0; $counter -lt $usuarios.Count;$counter++){
        If (-not ($UserList -contains $usuarios[$counter])){
            $UserList += $usuarios[$counter]
        }
    }
    $usuarios = get-childitem C:\Users\ | ForEach-Object  Name
    $results = $usuarios | Out-String
    for ($counter = 0; $counter -lt $usuarios.Count;$counter++){
        If (-not ($UserList -contains $usuarios[$counter])){
            $UserList += $usuarios[$counter]
        }
    }
    $usuarios = dir C:\Users\ | ForEach-Object  Name  
    $results += $usuarios | Out-String
    for ($counter = 0; $counter -lt $usuarios.Count;$counter++){
        If (-not ($UserList -contains $usuarios[$counter])){
            $UserList += $usuarios[$counter]
        }
    }
    $groups = get-localgroup | ForEach-Object  Name  
    $results += $groups | Out-String
    for ($counter = 0; $counter -lt $groups.Count;$counter++){    
        $usuarios = net localgroup $groups[$counter] | ForEach-Object  Name
        for ($i = 0; $i -lt $usuarios.Count;$i++){    
            $usuario = ($usuarios[$i]| out-string).split(' ')
            $usuario = $usuario.Trim()
            if ($usuario -ne ""){
                If (-not ($UserList -contains $usuario)){
                    $UserList += $usuario
                }
            }
        }
    }

    $listado = cmdkey.exe /list  
    $results += $listado  | Out-String
    $global:execute = $results
}
