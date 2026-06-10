$base = "D:\XOGO\BRUNO\XOGO-staging-v2-API"

function Write-BruFile {
    param(
        [string]$Filename,
        [string]$Name,
        [int]$Seq,
        [string]$Method,
        [string]$ApiPath,
        [bool]$HasBody = $false
    )

    $url = "{{baseUrl}}/v2$ApiPath"
    $nl = "`n"

    $meta = "meta {${nl}  name: $Name${nl}  type: http${nl}  seq: $Seq${nl}}"

    if ($HasBody) {
        $methodBlock = "$Method {${nl}  url: $url${nl}  body: json${nl}  auth: none${nl}}"
        $headerBlock = "headers {${nl}  Content-Type: application/json${nl}  x-api-version: {{x-api-version}}${nl}  x-manager-key: {{authToken}}${nl}}"
        $bodyBlock = "body:json {${nl}  {}${nl}}"
    } else {
        $methodBlock = "$Method {${nl}  url: $url${nl}  body: none${nl}  auth: none${nl}}"
        $headerBlock = "headers {${nl}  x-api-version: {{x-api-version}}${nl}  x-manager-key: {{authToken}}${nl}}"
        $bodyBlock = $null
    }

    if ($Method -eq "delete" -or $Method -eq "head") {
        $testBlock = "tests {${nl}  test(`"Status is 200`", function() {${nl}    expect(res.getStatus()).to.equal(200);${nl}  });${nl}}"
    } else {
        $testBlock = "tests {${nl}  test(`"Status is 200`", function() {${nl}    expect(res.getStatus()).to.equal(200);${nl}  });${nl}${nl}  test(`"Response is not empty`", function() {${nl}    expect(res.getBody()).to.not.be.empty;${nl}  });${nl}}"
    }

    $parts = [System.Collections.ArrayList]@($meta, $methodBlock, $headerBlock)
    if ($null -ne $bodyBlock) { [void]$parts.Add($bodyBlock) }
    [void]$parts.Add($testBlock)

    $content = ($parts -join "${nl}${nl}") + "${nl}"
    $utf8NoBom = [System.Text.UTF8Encoding]::new($false)
    [System.IO.File]::WriteAllText((Join-Path $base $Filename), $content, $utf8NoBom)
}

# ===== ACCOUNTS (seq 10-30) =====
Write-BruFile "get-player-license-info.bru"    "Get Player License Info"          10 "get"    "/api/admin/account/licenses/players-license-info/{{billingCycle}}"
Write-BruFile "delete-account-license.bru"     "Delete Account License"           11 "delete" "/api/admin/account/licenses/{{billingCycle}}/{{licenseQuantity}}"
Write-BruFile "retry-payment.bru"              "Retry Payment"                    12 "post"   "/api/admin/account/licenses/retry-payment"                            $true
Write-BruFile "apply-coupon.bru"               "Apply Coupon"                     13 "post"   "/api/admin/accounts/apply-coupon"                                     $true
Write-BruFile "get-billing-update.bru"         "Get Billing Update"               14 "get"    "/api/admin/accounts/billing/update"
Write-BruFile "upgrade-billing.bru"            "Upgrade Billing"                  15 "post"   "/api/admin/accounts/billing/upgrade/{{billingCycle}}/{{couponCode}}"   $true
Write-BruFile "cancel-billing-upgrade.bru"     "Cancel Billing Upgrade"           16 "post"   "/api/admin/accounts/billing/upgrade/cancel"                           $true
Write-BruFile "billing-upgrade-success.bru"    "Billing Upgrade Success"          17 "post"   "/api/admin/accounts/billing/upgrade/success"                          $true
Write-BruFile "delete-account.bru"             "Delete Account"                   18 "delete" "/api/admin/accounts/delete"
Write-BruFile "edit-account.bru"               "Edit Account"                     19 "put"    "/api/admin/accounts/edit"                                             $true
Write-BruFile "handover-account.bru"           "Handover Account"                 20 "post"   "/api/admin/accounts/handover"                                         $true
Write-BruFile "get-accounts-licenses.bru"      "Get Accounts Licenses"            21 "get"    "/api/admin/accounts/licenses"
Write-BruFile "delete-accounts-license.bru"    "Delete Accounts License"          22 "delete" "/api/admin/accounts/licenses/{{licenseId}}"
Write-BruFile "add-license.bru"                "Add License"                      23 "post"   "/api/admin/accounts/licenses/add"                                     $true
Write-BruFile "renew-license.bru"              "Renew License"                    24 "post"   "/api/admin/accounts/licenses/renew"                                   $true
Write-BruFile "get-accounts-metrics.bru"       "Get Accounts Metrics"             25 "get"    "/api/admin/accounts/metrics"
Write-BruFile "get-reseller-code.bru"          "Get Reseller Code"                26 "get"    "/api/admin/accounts/reseller-code"
Write-BruFile "accounts-single-sub-licenses.bru" "Get Accounts Single Sub Licenses" 27 "get"  "/api/admin/accounts/single-subscription/licenses"
Write-BruFile "use-reseller-code.bru"          "Use Reseller Code"                28 "post"   "/api/admin/accounts/use-reseller-code"                                $true
Write-BruFile "validate-coupon.bru"            "Validate Coupon"                  29 "get"    "/api/admin/accounts/validatecoupon/{{couponCode}}"
Write-BruFile "validate-reseller-code.bru"     "Validate Reseller Code"           30 "get"    "/api/admin/accounts/validate-reseller-code"

# ===== ADMIN COMPANY SETTINGS (seq 31-35) =====
Write-BruFile "get-company-settings.bru"            "Get Company Settings"              31 "get"  "/api/admin/company-settings"
Write-BruFile "set-dashboard-type.bru"              "Set Dashboard Type"                32 "post" "/api/admin/company-settings/dashboard-type"                       $true
Write-BruFile "enable-team-feature.bru"             "Enable Team Feature"               33 "post" "/api/admin/company-settings/enable-team-feature"                 $true
Write-BruFile "get-last-disable-teams-request.bru"  "Get Last Disable Teams Request"    34 "get"  "/api/admin/company-settings/last-disable-teams-request-datetime"
Write-BruFile "request-disable-teams.bru"           "Request Disable Teams"             35 "post" "/api/admin/company-settings/request-disable-teams-feature"       $true

# ===== ADMIN COMPANY TEAMS (seq 36-44) =====
Write-BruFile "delete-team-by-id.bru"          "Delete Team by ID"            36 "delete" "/api/admin/company-teams/{{teamId}}"
Write-BruFile "get-team-details.bru"           "Get Team Details"             37 "get"    "/api/admin/company-teams/{{teamId}}/details"
Write-BruFile "get-team-users.bru"             "Get Team Users"               38 "get"    "/api/admin/company-teams/{{teamId}}/team-users"
Write-BruFile "get-users-not-in-team.bru"      "Get Users Not In Team"        39 "get"    "/api/admin/company-teams/{{teamId}}/users-not-inteam"
Write-BruFile "create-team.bru"                "Create Team"                  40 "post"   "/api/admin/company-teams/create"                                      $true
Write-BruFile "delete-team.bru"                "Delete Team"                  41 "delete" "/api/admin/company-teams/delete/{{teamId}}"
Write-BruFile "edit-team.bru"                  "Edit Team"                    42 "put"    "/api/admin/company-teams/edit"                                        $true
Write-BruFile "get-team-users-v2.bru"          "Get Team Users v2"            43 "get"    "/api/admin/company-teams/team-users/{{teamId}}"
Write-BruFile "get-users-not-in-team-v2.bru"   "Get Users Not In Team v2"     44 "get"    "/api/admin/company-teams/users-not-inteam/{{teamId}}"

# ===== ADMIN HOME (seq 45) =====
Write-BruFile "add-company-registration-requests.bru" "Add Company Registration Requests" 45 "post" "/api/admin/home/add-companyregistration-requests" $true

# ===== ADMIN MEMBERS (seq 46-56) =====
Write-BruFile "get-members.bru"                       "Get Members"                       46 "get"    "/api/admin/members"
Write-BruFile "resend-invite.bru"                     "Resend Invite"                     47 "post"   "/api/admin/members/{{inviteId}}/resend-invite"               $true
Write-BruFile "revoke-invite.bru"                     "Revoke Invite"                     48 "put"    "/api/admin/members/{{inviteId}}/revoke-invite"               $true
Write-BruFile "admin-member-initiate-email-change.bru" "Admin Member Initiate Email Change" 49 "post"  "/api/admin/members/{{memberId}}/initiate-email-change"       $true
Write-BruFile "approve-member.bru"                    "Approve Member"                    50 "post"   "/api/admin/members/approve/{{id}}"                           $true
Write-BruFile "approve-on-team-enable.bru"            "Approve On Team Enable"            51 "post"   "/api/admin/members/approve-on-team-enable"                   $true
Write-BruFile "get-invite-company-info.bru"           "Get Invite Company Info"           52 "get"    "/api/admin/members/invite/companyInfo/{{companyToken}}"
Write-BruFile "get-invite-info.bru"                   "Get Invite Info"                   53 "get"    "/api/admin/members/invite/inviteInfo/{{inviteToken}}"
Write-BruFile "get-invites.bru"                       "Get Invites"                       54 "get"    "/api/admin/members/invites"
Write-BruFile "reject-member.bru"                     "Reject Member"                     55 "post"   "/api/admin/members/reject/{{id}}"                            $true
Write-BruFile "remove-member.bru"                     "Remove Member"                     56 "delete" "/api/admin/members/remove/{{id}}"

# ===== ADMIN PLAYERS (seq 57-61) =====
Write-BruFile "export-players-csv.bru"             "Export Players CSV"              57 "get"  "/api/admin/players/export-csv"
Write-BruFile "get-admin-player-licenses.bru"      "Get Admin Player Licenses"       58 "get"  "/api/admin/players/licenses"
Write-BruFile "update-admin-player.bru"            "Update Admin Player"             59 "post" "/api/admin/players/update"                              $true
Write-BruFile "get-single-sub-player-licenses.bru" "Get Single Sub Player Licenses"  60 "get"  "/api/admin/single-subscription/players/licenses"
Write-BruFile "update-single-sub-player.bru"       "Update Single Sub Player"        61 "post" "/api/admin/single-subscription/players/update"          $true

# ===== ADMIN TEAM USER (seq 62-67) =====
Write-BruFile "add-multiple-users.bru"             "Add Multiple Users"              62 "post" "/api/admin/team-user/add-multiple-users"                            $true
Write-BruFile "approve-team-access-request.bru"    "Approve Team Access Request"     63 "post" "/api/admin/team-user/approve-team-access-request/{{requestId}}"     $true
Write-BruFile "reject-team-access-request.bru"     "Reject Team Access Request"      64 "post" "/api/admin/team-user/reject-team-access-request/{{requestId}}"      $true
Write-BruFile "remove-team-user.bru"               "Remove Team User"                65 "post" "/api/admin/team-user/remove-teamuser"                               $true
Write-BruFile "update-access-rights.bru"           "Update Access Rights"            66 "post" "/api/admin/team-user/update-access-rights"                          $true
Write-BruFile "update-team-user.bru"               "Update Team User"                67 "post" "/api/admin/team-user/update-team-user"                              $true

# ===== ASSETS (seq 68) =====
Write-BruFile "upload-asset.bru" "Upload Asset" 68 "post" "/api/assets" $true

# ===== COMPANIES / ACCESS TOKENS (seq 69-71) =====
Write-BruFile "check-company-name.bru"    "Check Company Name"    69 "head" "/api/companies/{{companyName}}"
Write-BruFile "generate-access-token.bru" "Generate Access Token" 70 "post" "/api/companies/accesstoken/generate"  $true
Write-BruFile "get-access-tokens.bru"     "Get Access Tokens"     71 "get"  "/api/companies/accesstokens"

# ===== COMPANY AI INTEGRATIONS (seq 72-77) =====
Write-BruFile "get-ai-integrations.bru"   "Get AI Integrations"   72 "get"    "/api/company/ai-integrations"
Write-BruFile "create-ai-integration.bru" "Create AI Integration" 73 "post"   "/api/company/ai-integrations"            $true
Write-BruFile "get-ai-integration.bru"    "Get AI Integration"    74 "get"    "/api/company/ai-integrations/{{id}}"
Write-BruFile "update-ai-integration.bru" "Update AI Integration" 75 "put"    "/api/company/ai-integrations/{{id}}"     $true
Write-BruFile "delete-ai-integration.bru" "Delete AI Integration" 76 "delete" "/api/company/ai-integrations/{{id}}"
Write-BruFile "test-ai-integration.bru"   "Test AI Integration"   77 "post"   "/api/company/ai-integrations/{{id}}/test" $true

# ===== COMPANY KEY VALUE TAGS (seq 78-81) =====
Write-BruFile "get-key-value-tags.bru"   "Get Key Value Tags"   78 "get"    "/api/Company/keyvaluetags"
Write-BruFile "get-key-value-tag.bru"    "Get Key Value Tag"    79 "get"    "/api/Company/keyvaluetags/{{key}}"
Write-BruFile "update-key-value-tag.bru" "Update Key Value Tag" 80 "put"    "/api/Company/keyvaluetags/{{key}}"   $true
Write-BruFile "delete-key-value-tag.bru" "Delete Key Value Tag" 81 "delete" "/api/Company/keyvaluetags/{{key}}"

# ===== COMPANY TEAMS EXTRA (seq 82-88) =====
Write-BruFile "get-team.bru"                 "Get Team"                  82 "get"  "/api/company/teams/{{companyTeamId}}"
Write-BruFile "get-team-player-groups.bru"   "Get Team Player Groups"    83 "get"  "/api/company/teams/{{companyTeamId}}/PlayerGroups"
Write-BruFile "set-default-player-group.bru" "Set Default Player Group"  84 "post" "/api/company/teams/{{companyTeamId}}/playerGroups/default"  $true
Write-BruFile "assign-playlist-to-team.bru"  "Assign Playlist To Team"   85 "post" "/api/company/teams/{{companyTeamId}}/playlist"              $true
Write-BruFile "company-team-player-group.bru" "Get Company Team Player Group" 86 "get" "/api/company/teams/PlayerGroups/{{id}}"
Write-BruFile "request-team-access.bru"      "Request Team Access"       87 "post" "/api/company/teams/{{teamId}}/requestAccess"                $true
Write-BruFile "deduct-tokens.bru"            "Deduct Tokens"             88 "put"  "/api/company/tokens/deduct"                                 $true

# ===== DASHBOARD (seq 89-90) =====
Write-BruFile "get-dashboard-activity.bru" "Get Dashboard Activity" 89 "get" "/api/dashboard/activity"
Write-BruFile "get-system-status.bru"       "Get System Status"       90 "get" "/api/dashboard/system-status"

# ===== DEVICES (seq 91-92) =====
Write-BruFile "get-device-types.bru"        "Get Device Types"         91 "get" "/api/devicetypes"
Write-BruFile "get-display-orientations.bru" "Get Display Orientations" 92 "get" "/api/displayorientations"

# ===== LIBRARY EXTRA (seq 93-99) =====
Write-BruFile "get-library-item.bru"          "Get Library Item"          93 "get"    "/api/LibraryItems/{{id}}"
Write-BruFile "get-failover-usage.bru"        "Get Failover Usage"        94 "get"    "/api/LibraryItems/{{id}}/failoverusage"
Write-BruFile "get-item-playlists.bru"        "Get Item Playlists"        95 "get"    "/api/LibraryItems/{{id}}/playlists"
Write-BruFile "update-library-item.bru"       "Update Library Item"       96 "put"    "/api/LibraryItems"                        $true
Write-BruFile "update-item-metadata.bru"      "Update Item Metadata"      97 "put"    "/api/LibraryItems/{{id}}/metadata"        $true
Write-BruFile "bulk-delete-library-items.bru" "Bulk Delete Library Items" 98 "delete" "/api/LibraryItems/bulkdelete"
Write-BruFile "get-library-item-tags.bru"     "Get Library Item Tags"     99 "get"    "/api/LibraryItems/libraryitemtags"

# ===== OVERLAYS EXTRA (seq 100-101) =====
Write-BruFile "get-overlay.bru"          "Get Overlay"          100 "get"    "/api/Overlays/{{id}}"
Write-BruFile "bulk-delete-overlays.bru" "Bulk Delete Overlays" 101 "delete" "/api/Overlays/bulkdelete"

# ===== PLAYER GROUPS (seq 102-107) =====
Write-BruFile "get-player-group.bru"          "Get Player Group"           102 "get"    "/api/PlayerGroups/{{groupId}}"
Write-BruFile "delete-player-group.bru"       "Delete Player Group"        103 "delete" "/api/PlayerGroups/{{groupId}}"
Write-BruFile "add-player-to-group.bru"       "Add Player To Group"        104 "post"   "/api/PlayerGroups/{{groupId}}/player/{{playerId}}" $true
Write-BruFile "create-player-group.bru"       "Create Player Group"        105 "post"   "/api/PlayerGroups"                                  $true
Write-BruFile "update-player-group.bru"       "Update Player Group"        106 "put"    "/api/PlayerGroups"                                  $true
Write-BruFile "bulk-update-player-groups.bru" "Bulk Update Player Groups"  107 "put"    "/api/PlayerGroups/bulk"                             $true

# ===== PLAYERS EXTRA (seq 108-124) =====
Write-BruFile "create-player.bru"           "Create Player"           108 "post"   "/api/Players"                          $true
Write-BruFile "update-player.bru"           "Update Player"           109 "put"    "/api/Players/{{id}}"                   $true
Write-BruFile "update-player-metadata.bru"  "Update Player Metadata"  110 "put"    "/api/Players/{{id}}/metadata"          $true
Write-BruFile "reset-player.bru"            "Reset Player"            111 "put"    "/api/Players/{{id}}/reset"             $true
Write-BruFile "decode-player-pin.bru"       "Decode Player PIN"       112 "get"    "/api/Players/{{id}}/DecodePlayerPin"
Write-BruFile "get-player-tags.bru"         "Get Player Tags"         113 "get"    "/api/Players/{{id}}/GetTags"
Write-BruFile "add-update-player-tags.bru"  "Add Update Player Tags"  114 "post"   "/api/Players/{{id}}/TagAddUpdate"      $true
Write-BruFile "get-latest-hashes.bru"       "Get Latest Hashes"       115 "get"    "/api/Players/{{id}}/latestHashes"
Write-BruFile "get-player-screenshot.bru"   "Get Player Screenshot"   116 "get"    "/api/Players/{{id}}/screenshot"
Write-BruFile "get-player-status.bru"       "Get Player Status"       117 "get"    "/api/Players/{{id}}/status"
Write-BruFile "update-player-status.bru"    "Update Player Status"    118 "patch"  "/api/Players/{{id}}/status"            $true
Write-BruFile "player-checkin.bru"          "Player Checkin"          119 "post"   "/api/Players/{{id}}/Checkin"           $true
Write-BruFile "get-player-limitations.bru"  "Get Player Limitations"  120 "get"    "/api/Players/limitations"
Write-BruFile "get-player-types.bru"        "Get Player Types"        121 "get"    "/api/Players/types"
Write-BruFile "batch-operation.bru"         "Batch Operation"         122 "post"   "/api/Players/batchoperation"           $true
Write-BruFile "is-player-deleted.bru"       "Is Player Deleted"       123 "post"   "/api/Players/IsPlayerDeleted"          $true
Write-BruFile "migrate-player.bru"          "Migrate Player"          124 "post"   "/api/Players/api/Players/migrate"      $true

# ===== PLAYLISTS EXTRA (seq 125-133) =====
Write-BruFile "get-playlist.bru"              "Get Playlist"              125 "get"    "/api/Playlists/{{id}}"
Write-BruFile "update-playlist.bru"           "Update Playlist"           126 "put"    "/api/Playlists"                           $true
Write-BruFile "is-playlist-in-use.bru"        "Is Playlist In Use"        127 "get"    "/api/Playlists/{{id}}/IsPlaylistInUse"
Write-BruFile "bulk-replace-library-item.bru" "Bulk Replace Library Item" 128 "post"   "/api/Playlists/BulkReplaceLibraryItem"    $true
Write-BruFile "get-planner.bru"               "Get Planner"               129 "get"    "/api/Playlists/Planner"
Write-BruFile "add-update-planner.bru"        "Add Update Planner"        130 "post"   "/api/Playlists/Planner/AddUpdate"         $true
Write-BruFile "create-planner-event.bru"      "Create Planner Event"      131 "post"   "/api/Playlists/Planner/Event"             $true
Write-BruFile "add-update-planner-event.bru"  "Add Update Planner Event"  132 "post"   "/api/Playlists/Planner/Event/AddUpdate"   $true
Write-BruFile "delete-planner-event.bru"      "Delete Planner Event"      133 "delete" "/api/Playlists/Planner/Event/{{id}}"

# ===== REFERRAL (seq 134-135) =====
Write-BruFile "validate-referral-code.bru" "Validate Referral Code" 134 "get" "/api/Referral/{{referralCode}}/isvalidreferralCode"
Write-BruFile "get-referral-link.bru"       "Get Referral Link"       135 "get" "/api/Referral/link"

# ===== SINGLE SUBSCRIPTION (seq 136) =====
Write-BruFile "single-sub-licenses.bru" "Get Single Subscription Licenses" 136 "get" "/api/singleSubscription/Licenses"

# ===== SSO (seq 137-139) =====
Write-BruFile "get-sso-providers.bru" "Get SSO Providers" 137 "get"  "/api/sso/providers"
Write-BruFile "register-sso.bru"       "Register SSO"       138 "post" "/api/sso/register"    $true
Write-BruFile "sso-user-login.bru"     "SSO User Login"     139 "post" "/api/sso/userlogin"   $true

# ===== TEAMS PLAYER (seq 140-142) =====
Write-BruFile "get-player-auth-token.bru" "Get Player Auth Token" 140 "get" "/api/teams/player/{{deviceId}}/authtoken"
Write-BruFile "get-player-playlist.bru"   "Get Player Playlist"   141 "get" "/api/teams/player/{{deviceId}}/playlist"
Write-BruFile "validate-player.bru"       "Validate Player"       142 "get" "/api/teams/player/{{deviceId}}/validate"

# ===== USER EMAIL VALIDATION (seq 143-148) =====
Write-BruFile "complete-email-change.bru"  "Complete Email Change"  143 "post" "/api/UserEmailValidation/CompleteEmailChange"           $true
Write-BruFile "initiate-email-change.bru"  "Initiate Email Change"  144 "post" "/api/UserEmailValidation/InitiateEmailChange"           $true
Write-BruFile "send-code.bru"              "Send Code"               145 "post" "/api/UserEmailValidation/sendCode"                     $true
Write-BruFile "send-validation-email.bru"  "Send Validation Email"  146 "get"  "/api/UserEmailValidation/SendValidationEmail"
Write-BruFile "validate-by-token.bru"      "Validate By Token"       147 "get"  "/api/UserEmailValidation/UserEmailValidationByToken"
Write-BruFile "validate-code.bru"          "Validate Code"           148 "post" "/api/UserEmailValidation/validateCode"                 $true

# ===== USERS EXTRA (seq 149-159) =====
Write-BruFile "get-user-team-info.bru"       "Get User Team Info"       149 "get"    "/api/users/{{userId}}/teaminfo"
Write-BruFile "delete-user.bru"              "Delete User"              150 "delete" "/api/users/{{email}}"
Write-BruFile "change-password.bru"          "Change Password"          151 "put"    "/api/users/changepassword"                   $true
Write-BruFile "change-password-by-token.bru" "Change Password By Token" 152 "put"    "/api/users/changepassword/{{token}}"         $true
Write-BruFile "check-email.bru"              "Check Email"              153 "get"    "/api/users/check-email"
Write-BruFile "cross-site-token.bru"         "Cross Site Token"         154 "post"   "/api/users/crosssitetoken"                   $true
Write-BruFile "forgot-password.bru"          "Forgot Password"          155 "post"   "/api/users/forgotpassword"                   $true
Write-BruFile "is-valid-entra-email.bru"     "Is Valid Entra Email"     156 "get"    "/api/users/IsValidEntraEmail/{{emailDomain}}"
Write-BruFile "get-user-settings.bru"        "Get User Settings"        157 "get"    "/api/users/settings"
Write-BruFile "update-user-settings.bru"     "Update User Settings"     158 "put"    "/api/users/settings"                         $true
Write-BruFile "sso-login.bru"                "SSO Login"                159 "post"   "/api/users/ssologin"                         $true

# ===== UTILS (seq 160-162) =====
Write-BruFile "get-localization.bru" "Get Localization" 160 "get"  "/api/Utils/localization"
Write-BruFile "generate-qr.bru"       "Generate QR Code" 161 "post" "/api/Utils/qr"              $true
Write-BruFile "get-timezones.bru"     "Get Timezones"    162 "get"  "/api/Utils/timezones"

Write-Host "Done! Total .bru files in collection:"
(Get-ChildItem $base -Filter "*.bru").Count
