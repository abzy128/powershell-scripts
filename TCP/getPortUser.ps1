<#PSScriptInfo
.VERSION 1.0
.GUID 14c18ad5-022c-4c38-a8ed-07d14374b24f
.AUTHOR Abzal Orazbek
#>

<# 
.DESCRIPTION 
 Some description here
#> 
Param (
    [Parameter(Mandatory = $true, Position = 0)]
    [UInt16]
    $Port
)
$tcpConnection = Get-NetTCPConnection -State Listen | Where-Object LocalPort -EQ $Port
if($null -eq $tcpConnection){
    Write-Host "Port is not used for Listening" -ForegroundColor Yellow;
    Exit 1;
}
Write-Output $tcpConnection
$tcpProcess = Get-Process -Id $tcpConnection.OwningProcess
Write-Output $tcpProcess
query.exe session $tcpProcess.SessionId