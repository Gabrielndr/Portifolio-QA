param(
  [string]$BaseUrl = 'http://localhost:8080',
  [string]$ReportDir = 'tests/reports',
  [switch]$SmokeProfile
)

$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path

Push-Location $Root
try {
  $env:BASE_URL = $BaseUrl
  $env:REPORT_DIR = $ReportDir
  $env:PROFILE = if ($SmokeProfile) { 'smoke' } else { 'portfolio' }

  New-Item -ItemType Directory -Force -Path (Join-Path $Root $ReportDir) | Out-Null

  k6 run .\tests\smoke_contract.js
  k6 run .\tests\load_get_cars.js
  k6 run .\tests\load_post_error.js
  k6 run .\tests\stress_post_success.js
}
finally {
  Pop-Location
}
