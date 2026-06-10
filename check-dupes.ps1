$lines = Get-Content "D:\XOGO\BRUNO\create-bruno-files.ps1"
$names = @()
foreach ($line in $lines) {
    if ($line -match 'Write-BruFile\s+"[^"]+"\s+"([^"]+\.bru)"') {
        $names += $Matches[1]
    }
}
$names | Group-Object | Where-Object { $_.Count -gt 1 } | Select-Object Name, Count
Write-Host "Total files: $($names.Count)"
