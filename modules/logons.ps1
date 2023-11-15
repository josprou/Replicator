function logons{
  $logons = (Get-EventLog security | Where-Object {$_.TimeGenerated -gt '9/15/16'} | Where-Object {($_.InstanceID -eq 4634) -or ($_.InstanceID -eq 4624)} | Select-Object TimeGenerated | select -last 20).TimeGenerated
  return @{results=$logons;success=$true}
}
