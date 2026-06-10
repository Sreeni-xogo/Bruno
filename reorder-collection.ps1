$base = "D:\XOGO\BRUNO\XOGO-staging-v2-API"

# --- Delete removed files ---
Remove-Item (Join-Path $base "sso-login.bru")          -ErrorAction SilentlyContinue
Remove-Item (Join-Path $base "sso-user-login.bru")     -ErrorAction SilentlyContinue
Remove-Item (Join-Path $base "is-valid-entra-email.bru") -ErrorAction SilentlyContinue

# --- Helper: update seq in a file ---
function Set-Seq {
    param([string]$Filename, [int]$Seq)
    $path = Join-Path $base $Filename
    if (Test-Path $path) {
        $content = [System.IO.File]::ReadAllText($path)
        $content = $content -replace 'seq: \d+', "seq: $Seq"
        $utf8NoBom = [System.Text.UTF8Encoding]::new($false)
        [System.IO.File]::WriteAllText($path, $content, $utf8NoBom)
    } else {
        Write-Warning "NOT FOUND: $Filename"
    }
}

# ========================
# AUTH
# ========================
Set-Seq "signup.bru"                    1
Set-Seq "login.bru"                     2

# ========================
# USER
# ========================
Set-Seq "user-summary.bru"              3
Set-Seq "get-user-settings.bru"         4
Set-Seq "update-user-settings.bru"      5
Set-Seq "get-user-team-info.bru"        6
Set-Seq "check-email.bru"               7
Set-Seq "forgot-password.bru"           8
Set-Seq "change-password.bru"           9
Set-Seq "change-password-by-token.bru"  10
Set-Seq "cross-site-token.bru"          11

# ========================
# SUMMARY / HOME
# ========================
Set-Seq "company-summary.bru"           12
Set-Seq "get-dashboard-activity.bru"    13
Set-Seq "get-system-status.bru"         14
Set-Seq "get-accounts-metrics.bru"      15

# ========================
# LIBRARY
# ========================
Set-Seq "get-library-item-tags.bru"     16
Set-Seq "get-library-item.bru"          17
Set-Seq "get-failover-usage.bru"        18
Set-Seq "get-item-playlists.bru"        19
Set-Seq "upload-asset.bru"              20
Set-Seq "update-library-item.bru"       21
Set-Seq "update-item-metadata.bru"      22
Set-Seq "bulk-delete-library-items.bru" 23

# ========================
# PLAYLISTS
# ========================
Set-Seq "get-playlist.bru"              24
Set-Seq "is-playlist-in-use.bru"        25
Set-Seq "update-playlist.bru"           26
Set-Seq "bulk-replace-library-item.bru" 27

# ========================
# PLANNER
# ========================
Set-Seq "get-planner.bru"               28
Set-Seq "add-update-planner.bru"        29
Set-Seq "create-planner-event.bru"      30
Set-Seq "add-update-planner-event.bru"  31
Set-Seq "delete-planner-event.bru"      32

# ========================
# OVERLAYS
# ========================
Set-Seq "get-overlay.bru"               33
Set-Seq "bulk-delete-overlays.bru"      34

# ========================
# PLAYERS
# ========================
Set-Seq "get-player.bru"                35
Set-Seq "get-player-limitations.bru"    36
Set-Seq "get-player-types.bru"          37
Set-Seq "get-player-status.bru"         38
Set-Seq "get-player-screenshot.bru"     39
Set-Seq "get-player-tags.bru"           40
Set-Seq "get-latest-hashes.bru"         41
Set-Seq "decode-player-pin.bru"         42
Set-Seq "create-player.bru"             43
Set-Seq "player-checkin.bru"            44
Set-Seq "add-update-player-tags.bru"    45
Set-Seq "batch-operation.bru"           46
Set-Seq "is-player-deleted.bru"         47
Set-Seq "migrate-player.bru"            48
Set-Seq "update-player.bru"             49
Set-Seq "update-player-metadata.bru"    50
Set-Seq "reset-player.bru"              51
Set-Seq "update-player-status.bru"      52

# ========================
# PLAYER GROUPS
# ========================
Set-Seq "get-player-group.bru"          53
Set-Seq "create-player-group.bru"       54
Set-Seq "add-player-to-group.bru"       55
Set-Seq "update-player-group.bru"       56
Set-Seq "bulk-update-player-groups.bru" 57
Set-Seq "delete-player-group.bru"       58

# ========================
# TEAMS / COMPANY TEAMS
# ========================
Set-Seq "get-team.bru"                  59
Set-Seq "get-team-details.bru"          60
Set-Seq "get-team-users.bru"            61
Set-Seq "get-team-users-v2.bru"         62
Set-Seq "get-users-not-in-team.bru"     63
Set-Seq "get-users-not-in-team-v2.bru"  64
Set-Seq "get-team-player-groups.bru"    65
Set-Seq "company-team-player-group.bru" 66
Set-Seq "create-team.bru"               67
Set-Seq "assign-playlist-to-team.bru"   68
Set-Seq "set-default-player-group.bru"  69
Set-Seq "request-team-access.bru"       70
Set-Seq "edit-team.bru"                 71
Set-Seq "delete-team-by-id.bru"         72
Set-Seq "delete-team.bru"               73

# ========================
# MEMBERS / INVITES
# ========================
Set-Seq "get-members.bru"                       74
Set-Seq "get-invites.bru"                       75
Set-Seq "get-invite-company-info.bru"           76
Set-Seq "get-invite-info.bru"                   77
Set-Seq "resend-invite.bru"                     78
Set-Seq "revoke-invite.bru"                     79
Set-Seq "approve-member.bru"                    80
Set-Seq "approve-on-team-enable.bru"            81
Set-Seq "reject-member.bru"                     82
Set-Seq "admin-member-initiate-email-change.bru" 83
Set-Seq "remove-member.bru"                     84

# ========================
# TEAM-USER ACCESS
# ========================
Set-Seq "add-multiple-users.bru"            85
Set-Seq "update-access-rights.bru"          86
Set-Seq "update-team-user.bru"              87
Set-Seq "approve-team-access-request.bru"   88
Set-Seq "reject-team-access-request.bru"    89
Set-Seq "remove-team-user.bru"              90

# ========================
# LICENSES
# ========================
Set-Seq "get-accounts-licenses.bru"         91
Set-Seq "get-admin-player-licenses.bru"     92
Set-Seq "get-single-sub-player-licenses.bru" 93
Set-Seq "accounts-single-sub-licenses.bru"  94
Set-Seq "single-sub-licenses.bru"           95
Set-Seq "get-player-license-info.bru"       96
Set-Seq "add-license.bru"                   97
Set-Seq "renew-license.bru"                 98
Set-Seq "update-admin-player.bru"           99
Set-Seq "update-single-sub-player.bru"      100
Set-Seq "retry-payment.bru"                 101
Set-Seq "delete-accounts-license.bru"       102
Set-Seq "delete-account-license.bru"        103

# ========================
# ACCOUNT / BILLING / SETTINGS
# ========================
Set-Seq "get-company-settings.bru"          104
Set-Seq "get-reseller-code.bru"             105
Set-Seq "validate-coupon.bru"               106
Set-Seq "validate-reseller-code.bru"        107
Set-Seq "get-billing-update.bru"            108
Set-Seq "set-dashboard-type.bru"            109
Set-Seq "enable-team-feature.bru"           110
Set-Seq "request-disable-teams.bru"         111
Set-Seq "use-reseller-code.bru"             112
Set-Seq "apply-coupon.bru"                  113
Set-Seq "upgrade-billing.bru"               114
Set-Seq "cancel-billing-upgrade.bru"        115
Set-Seq "billing-upgrade-success.bru"       116
Set-Seq "edit-account.bru"                  117

# ========================
# AI INTEGRATIONS
# ========================
Set-Seq "get-ai-integrations.bru"           118
Set-Seq "get-ai-integration.bru"            119
Set-Seq "create-ai-integration.bru"         120
Set-Seq "test-ai-integration.bru"           121
Set-Seq "update-ai-integration.bru"         122
Set-Seq "delete-ai-integration.bru"         123

# ========================
# COMPANY EXTRAS
# ========================
Set-Seq "get-key-value-tags.bru"            124
Set-Seq "get-key-value-tag.bru"             125
Set-Seq "update-key-value-tag.bru"          126
Set-Seq "delete-key-value-tag.bru"          127
Set-Seq "deduct-tokens.bru"                 128
Set-Seq "get-access-tokens.bru"             129
Set-Seq "generate-access-token.bru"         130
Set-Seq "check-company-name.bru"            131

# ========================
# SSO / EMAIL VALIDATION
# ========================
Set-Seq "get-sso-providers.bru"             132
Set-Seq "register-sso.bru"                  133
Set-Seq "send-validation-email.bru"         134
Set-Seq "initiate-email-change.bru"         135
Set-Seq "send-code.bru"                     136
Set-Seq "validate-code.bru"                 137
Set-Seq "validate-by-token.bru"             138
Set-Seq "complete-email-change.bru"         139

# ========================
# UTILITIES / MISC
# ========================
Set-Seq "get-device-types.bru"              140
Set-Seq "get-display-orientations.bru"      141
Set-Seq "get-localization.bru"              142
Set-Seq "get-timezones.bru"                 143
Set-Seq "generate-qr.bru"                   144
Set-Seq "get-referral-link.bru"             145
Set-Seq "validate-referral-code.bru"        146
Set-Seq "get-player-auth-token.bru"         147
Set-Seq "get-player-playlist.bru"           148
Set-Seq "validate-player.bru"               149

# ========================
# ADMIN REPORTS (v3 endpoints)
# ========================
Set-Seq "export-to-csv.bru"                 150
Set-Seq "report-licences.bru"               151
Set-Seq "generate-report-by-licenses.bru"   152

# ========================
# DESTRUCTIVE - END
# ========================
Set-Seq "export-players-csv.bru"            153
Set-Seq "add-company-registration-requests.bru" 154
Set-Seq "get-last-disable-teams-request.bru" 155
Set-Seq "handover-account.bru"              156
Set-Seq "delete-user.bru"                   157
Set-Seq "delete-account.bru"                158

Write-Host "Done."
Write-Host "Total .bru files: $((Get-ChildItem $base -Filter '*.bru').Count)"
