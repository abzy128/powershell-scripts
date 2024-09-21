Get-NetUDPEndPoint | Select-Object @{Name="Process";Expression={(Get-Process -Id $_.OwningProcess).ProcessName}}, LocalAddress, LocalPort | Sort-Object -Property LocalPort,Process
