$cores = (Get-WmiObject Win32_Processor).NumberOfLogicalProcessors
while ($true) {
    $tmp = Get-WmiObject Win32_PerfFormattedData_PerfProc_Process | 
    select-object -property Name, @{Name = "CPU"; Expression = {([Math]::Round(($_.PercentProcessorTime/$cores),2)) -replace ',','.'}}, @{Name = "PID"; Expression = {$_.IDProcess}}, @{"Name" = "Memory(MB)"; Expression = {[int]($_.WorkingSetPrivate/1mb)}} |
    Where-Object {$_.Name -notmatch "^(idle|_total|system)$"} |
    Sort-Object -Property CPU -Descending|
    Select-Object -First 10;
    cls;
    $tmp | Export-Csv -Path "C:\Program Files\Zabbix Agent 2\data\top10process.csv" -NoTypeInformation
    Start-Sleep 30
}