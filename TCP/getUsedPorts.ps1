<#PSScriptInfo
.VERSION 1.0
.GUID b55b2b0c-7196-4278-8c4b-93f242767676
.AUTHOR Abzal Orazbek
#>

<# 
.DESCRIPTION 
 Some description here
#> 
# Param ()
# DOES NOT WORK
# OUTPUT IS BLANK LIST?
$tcpConnections = Get-NetTCPConnection -State Listen
$processes = Get-Process
$quser = quser.exe | ForEach-Object -Process { $_ -replace '\s{2,}', ',' } | ConvertFrom-Csv

$tcpProcesses = $tcpConnections | ForEach-Object {
    ($item = $PSItem) |
    Select-Object -Property @{
                                Name       = "ProcessId"
                                Expression = "$item.OwningProcess"
                            },
                            @{
                                Name       = "ProcessName"
                                Expression = "$processes | Where-Object ID -EQ $item.OwningProcess | Select-Object ProcessName"
                            },
                            @{
                                Name       = "Port"
                                Expression = "$item.LocalPort"
                            },
                            @{
                                Name       = "User"
                                Expression = "$quser | Where-Object ID -EQ ($processes | Where-Object ID -EQ $ $item.OwningProcess).SessionId | Select-Object USERNAME"
                            }
} | Format-Table -AutoSize
Write-Output $tcpProcesses