# API Reference - Automation API Staging

**Base URL:** `https://api2-staging.xogo.io`
**API Version Header:** `x-api-version: 1.0`
**Auth Header:** `x-manager-key: <token>` (obtained from login)

---

## Auth

| Name | Method | Endpoint | Auth Required | Notes |
|---|---|---|---|---|
| Signup | POST | `/v2/api/users` | No | Creates user + company |
| Login | POST | `/v2/api/users/login` | No | Returns `token`, `user.id`, `user.defaultCompanyTeamId` |

---

## User

| Name | Method | Endpoint | Auth Required | Notes |
|---|---|---|---|---|
| User Summary | GET | `/v2/api/users` | Yes | Returns current user info |
| Update User | PUT | `/v2/api/admin/members/{{userid}}/personalInfo/update` | Yes | Body: `firstName`, `lastName` |
| Member Invite | POST | `/v2/api/admin/members/invite` | Yes | Body: `memberInvites[]` array |
| User Company Teams | GET | `/v2/api/admin/user/{{userid}}/company-teams?skip=0` | Yes | Teams linked to a user |

---

## Summary / Home

| Name | Method | Endpoint | Auth Required | Notes |
|---|---|---|---|---|
| Home Summary | GET | `/v2/api/home/summary` | Yes | Dashboard summary |
| Company Summary | GET | `/v2/api/company/summary` | Yes | Company-level summary |
| Admin Home | GET | `/v2/api/admin/home` | Yes | Admin home data |
| Admin Home Summary | GET | `/v2/api/admin/adminhome/summary` | Yes | Admin summary view |
| Admin Home Error | GET | `/v2/api/admin/home/error` | Yes | Error report |
| Admin Home Support (GET) | GET | `/v2/api/admin/home/support` | Yes | Support info |
| Admin Home Support (POST) | POST | `/v2/api/admin/home/support` | Yes | Body: `message`, `isSent` |
| Admin Check Company | POST | `/v2/api/admin/home/check-company` | Yes | Body: `companyName` |

---

## App Versions

| Name | Method | Endpoint | Auth Required | Notes |
|---|---|---|---|---|
| Manager Version | GET | `/v2/api/apps/manager/versions/latest` | Yes | Latest manager app version |

---

## Library

| Name | Method | Endpoint | Auth Required | Notes |
|---|---|---|---|---|
| Library Limitations | GET | `/v2/api/LibraryItems/limitations` | Yes | Storage/upload limits |
| Library (page 1) | GET | `/v2/api/LibraryItems?skip=0` | Yes | First 100 items |
| Library (page 4) | GET | `/v2/api/LibraryItems?skip=300` | Yes | Items from offset 300 |
| Upload URL Asset | POST | `/v2/api/LibraryItems` | Yes | `libraryItemType: "Url"` |
| Re-upload Image | POST | `/v2/api/LibraryItems` | Yes | `libraryItemType: "Image"`, include `id` to re-upload |
| Create Clock Widget | POST | `/v2/api/LibraryItems` | Yes | `libraryItemType: "WidgetClock"`, requires `CompanyTeamId` |
| Delete Library Item | DELETE | `/v2/api/LibraryItems?id={{itemId}}` | Yes | Works for URL, image, widget |

---

## Playlists

| Name | Method | Endpoint | Auth Required | Notes |
|---|---|---|---|---|
| Playlists (page 1) | GET | `/v2/api/Playlists?skip=0` | Yes | Full playlist objects |
| Playlists Basic | GET | `/v2/api/Playlists/Basic` | Yes | Lightweight list |
| Create Playlist | POST | `/v2/api/Playlists` | Yes | Body: `name`, `items[]` |
| Delete Playlist | DELETE | `/v2/api/Playlists?id={{playlist}}` | Yes | - |

---

## Overlays

| Name | Method | Endpoint | Auth Required | Notes |
|---|---|---|---|---|
| Overlays (page 1) | GET | `/v2/api/Overlays?skip=0` | Yes | - |
| Create Overlay | POST | `/v2/api/Overlays` | Yes | Body: `name`, `items[]`, `verticalPixels`, `horizontalPixels` |
| Edit Overlay | PUT | `/v2/api/Overlays` | Yes | Include `id` in body |
| Delete Overlay | DELETE | `/v2/api/Overlays?id={{overlayId}}` | Yes | - |

---

## Players

| Name | Method | Endpoint | Auth Required | Notes |
|---|---|---|---|---|
| Players Basic | GET | `/v2/api/Players/Basic` | Yes | Lightweight list, returns `playerId` |
| Get Players | GET | `/v2/api/Players?skip=0&companyTeamIds={{CompanyTeamsId}}` | Yes | Filtered by team |
| Get Players (all) | GET | `/v2/api/Players?skip=0` | Yes | All players |
| Get Player by ID | GET | `/v2/api/Players/{{playerid}}` | Yes | Single player detail |
| Create Player | POST | `/v2/api/Players/{{playerid}}` | Yes | Body: full player config incl. `licenseId`, `timeZone` |
| Delete Player | DELETE | `/v2/api/Players/{{playerid}}` | Yes | Expects 401 (not permitted) |
| Admin Players | GET | `/v2/api/admin/players` | Yes | Admin view of all players |

---

## Player Groups

| Name | Method | Endpoint | Auth Required | Notes |
|---|---|---|---|---|
| Player Groups | GET | `/v2/api/PlayerGroups?skip=0` | Yes | - |

---

## Teams / Company Teams

| Name | Method | Endpoint | Auth Required | Notes |
|---|---|---|---|---|
| Teams | GET | `/v2/api/company/teams?skip=0` | Yes | Company teams list |
| Company Teams (admin) | GET | `/v2/api/admin/company-teams?skip=0` | Yes | Admin team list |
| Company Teams Pending | GET | `/v2/api/admin/company-teams/pending-requests?skip=0` | Yes | Pending join requests |
| Company Teams Details | GET | `/v2/api/admin/company-teams/details/{{CompanyTeamsId}}` | Yes | Single team detail |

---

## Licenses

| Name | Method | Endpoint | Auth Required | Notes |
|---|---|---|---|---|
| Licenses | GET | `/v2/api/Licenses` | Yes | All licenses for the account |

---

## Environment Variables (Bruno - Staging)

| Variable | Description |
|---|---|
| `baseUrl` | `https://api2-staging.xogo.io` |
| `x-api-version` | `1.0` |
| `authToken` | Set by login response - use as `x-manager-key` |
| `userId` | Set by login response |
| `companyTeamId` | Set by login response (`user.defaultCompanyTeamId`) |
| `activeEmail` | Login email |
| `activeHashedPwd` | MD5-hashed password |
| `hashedTestPassword` | Test user password hash |
| `playerId` | Player ID for player-specific calls |
| `masterGroupName` | Used in admin report calls |
