$base = "D:\XOGO\BRUNO\XOGO-staging-v2-API"

# Delete remaining SSO files
Remove-Item (Join-Path $base "get-sso-providers.bru") -ErrorAction SilentlyContinue
Remove-Item (Join-Path $base "register-sso.bru")      -ErrorAction SilentlyContinue

# Renumber everything that was seq 134+ by subtracting 2
Get-ChildItem $base -Filter "*.bru" | ForEach-Object {
    $content = [System.IO.File]::ReadAllText($_.FullName)
    if ($content -match 'seq: (\d+)') {
        $seq = [int]$Matches[1]
        if ($seq -ge 134) {
            $content = $content -replace 'seq: \d+', "seq: $($seq - 2)"
            $utf8NoBom = [System.Text.UTF8Encoding]::new($false)
            [System.IO.File]::WriteAllText($_.FullName, $content, $utf8NoBom)
        }
    }
}

Write-Host "Done. Total .bru files: $((Get-ChildItem $base -Filter '*.bru').Count)"
