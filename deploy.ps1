# deploy.ps1 - UziChess simple deploy
# Körs från C:\Users\mkurt\uzichess-site
# Usage:  ./deploy.ps1

$ErrorActionPreference = "Stop"

$remoteHost = "uzichess"
$remotePath = "~/uzichess-site"
$webRoot    = "/var/www/uzichess"

Write-Host ""
Write-Host ">>> ================================================"
Write-Host ">>>   U Z I C H E S S   D E P L O Y   P R O T O C O L"
Write-Host ">>> ================================================"
Write-Host ""
Write-Host ">>> Initializing Tactical Upload Protocol..."
Start-Sleep -Milliseconds 300
Write-Host ">>> Authenticating Operator splokk..."
Start-Sleep -Milliseconds 300
Write-Host ">>> Synchronizing Frontline Assets with Server..."
Start-Sleep -Milliseconds 300
Write-Host ""
 

# 1. (Optional) Build step – avkommentera om du senare kör t.ex. npm build
# Write-Host ">> Running local build..."
# npm install
# npm run build

Write-Host ">> Syncing files to server: ${remoteHost}:${remotePath}"
scp -r * "${remoteHost}:${remotePath}"


if ($LASTEXITCODE -ne 0) {
    Write-Error "scp failed, aborting deploy."
    exit 1
}

Write-Host ">> Updating web root on server: $webRoot"

# 2. Kör kommandon på servern:
$remoteCommand = "set -e; mkdir -p $webRoot; sudo cp -r $remotePath/* $webRoot/; sudo systemctl reload nginx"

ssh $remoteHost $remoteCommand


if ($LASTEXITCODE -ne 0) {
    Write-Error "Remote deploy commands failed."
    exit 1
}

Write-Host ""
Write-Host ">>> Finalizing Webroot Integrity..."
Start-Sleep -Milliseconds 250
Write-Host ">>> Reloading NGINX Command Stack..."
Start-Sleep -Milliseconds 250
Write-Host ""
Write-Host ">>> ================================================"
Write-Host ">>>   O P E R A T I O N   U Z I - D E P L O Y :  S U C C E S S"
Write-Host ">>> ================================================"
Write-Host ""

