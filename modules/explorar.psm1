function explorar{
    $directories = (Get-ChildItem |Select-Object Name).Name
    foreach($dir in $directories){
      $dirs_parsed = $dirs_parsed + "`n" + $dir
    }
    return @{results=$dirs_parsed;success=$true)
}
