$base = "D:\XOGO\BRUNO\XOGO-staging-v2-API"
$checks = @(
    "signup.bru", "login.bru",
    "company-summary.bru",
    "get-library-item.bru", "bulk-delete-library-items.bru",
    "get-planner.bru", "delete-planner-event.bru",
    "get-player.bru", "update-player-status.bru",
    "delete-team.bru",
    "remove-member.bru",
    "delete-account-license.bru",
    "delete-ai-integration.bru",
    "generate-report-by-licenses.bru",
    "delete-user.bru", "delete-account.bru"
)
foreach ($f in $checks) {
    $path = Join-Path $base $f
    $seq = (Select-String -Path $path -Pattern "seq: \d+").Matches[0].Value
    Write-Host "$seq   $f"
}
