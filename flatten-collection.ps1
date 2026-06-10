$root = "D:\XOGO\BRUNO\XOGO-staging-v2-API"

# Move all .bru files from subfolders into root
Get-ChildItem $root -Recurse -Filter "*.bru" | Where-Object { $_.DirectoryName -ne $root } | ForEach-Object {
    Move-Item $_.FullName $root -Force
}

# Remove all subdirectories (except environments)
Get-ChildItem $root -Directory | Where-Object { $_.Name -ne "environments" } | Remove-Item -Recurse -Force

Write-Host "Done. Files in root:"
(Get-ChildItem $root -Filter "*.bru").Count
