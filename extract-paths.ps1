$json = Get-Content 'D:\XOGO\BRUNO\swagger.json' -Raw | ConvertFrom-Json
$results = @()
foreach ($path in $json.paths.PSObject.Properties) {
    foreach ($method in $path.Value.PSObject.Properties) {
        $results += "$($method.Name.ToUpper()) $($path.Name)"
    }
}
$results | Sort-Object
