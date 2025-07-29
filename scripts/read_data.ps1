param (
    [int]$Line = 0, # Default value

    [Parameter(Mandatory=$true)]
    [string]$ColumnName
)

$csvData = Import-Csv -Path "C:\Program Files\Zabbix Agent\data\top10process.csv"
$specificLine = $csvData[$line]
$columnValue = $specificLine.$ColumnName
Write-Host $columnValue

#exemple
# .\read_data.ps1 0 "Name"
# .\read_data.ps1 3 "CPU"
# .\read_data.ps1 9 "Memory(MB)"