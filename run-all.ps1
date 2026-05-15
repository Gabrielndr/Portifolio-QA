param(
  [switch]$Install,
  [switch]$SkipCypress,
  [switch]$SkipPostman,
  [switch]$SkipK6,
  [switch]$SkipRobot,
  [switch]$FullK6,
  [switch]$ContinueOnError
)

$ErrorActionPreference = 'Stop'
$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$Failures = @()

function Invoke-Step {
  param(
    [string]$Name,
    [scriptblock]$Action
  )

  Write-Host ''
  Write-Host "==> $Name"
  $startedAt = Get-Date

  try {
    & $Action
    $elapsed = (Get-Date) - $startedAt
    Write-Host ("OK: {0} ({1:n1}s)" -f $Name, $elapsed.TotalSeconds)
  }
  catch {
    $elapsed = (Get-Date) - $startedAt
    Write-Host ("FAIL: {0} ({1:n1}s)" -f $Name, $elapsed.TotalSeconds)
    Write-Host $_.Exception.Message
    $script:Failures += $Name

    if (-not $ContinueOnError) {
      throw
    }
  }
}

function Test-HttpReady {
  param([string]$Url)

  try {
    $response = Invoke-WebRequest -Uri $Url -UseBasicParsing -TimeoutSec 2
    return $response.StatusCode -ge 200 -and $response.StatusCode -lt 500
  }
  catch {
    return $false
  }
}

function Wait-HttpReady {
  param(
    [string]$Url,
    [int]$Attempts = 30
  )

  for ($attempt = 1; $attempt -le $Attempts; $attempt++) {
    if (Test-HttpReady -Url $Url) {
      return $true
    }

    Start-Sleep -Seconds 1
  }

  return $false
}

function Invoke-CypressSuite {
  $cypressRoot = Join-Path $RepoRoot 'Cypress'

  Push-Location $cypressRoot
  try {
    if ($Install) {
      npm ci
    }

    npm run cy:run
  }
  finally {
    Pop-Location
  }
}

function Invoke-PostmanSuite {
  $postmanRoot = Join-Path $RepoRoot 'Postman'

  Push-Location $postmanRoot
  try {
    if ($Install) {
      npm ci
    }

    npm test
  }
  finally {
    Pop-Location
  }
}

function Invoke-K6Suite {
  $k6Root = Join-Path $RepoRoot 'K6 + Mock'
  $wiremockUrl = 'http://localhost:8080/api/cars'
  $wiremockProcess = $null
  $startedWiremock = $false

  try {
    if (-not (Test-HttpReady -Url $wiremockUrl)) {
      $startArgs = @{
        FilePath = 'java'
        WorkingDirectory = $k6Root
        ArgumentList = @('-jar', 'wiremock-standalone-3.13.2.jar', '--port', '8080', '--root-dir', '.')
        PassThru = $true
      }

      if ($IsWindows -or $env:OS -eq 'Windows_NT') {
        $startArgs.WindowStyle = 'Hidden'
      }

      $wiremockProcess = Start-Process @startArgs
      $startedWiremock = $true

      if (-not (Wait-HttpReady -Url $wiremockUrl)) {
        throw 'WireMock did not become ready on http://localhost:8080/api/cars'
      }
    }

    Push-Location $k6Root
    try {
      $env:VUS = '1'
      $env:DURATION = '3s'

      if ($FullK6) {
        .\run-all.ps1
      }
      else {
        .\run-all.ps1 -SmokeProfile
      }
    }
    finally {
      Pop-Location
    }
  }
  finally {
    if ($startedWiremock -and $wiremockProcess -and -not $wiremockProcess.HasExited) {
      Stop-Process -Id $wiremockProcess.Id -Force
    }
  }
}

function Invoke-RobotSuite {
  $originalPath = $env:PATH

  try {
    if ($env:OS -eq 'Windows_NT') {
      $env:PATH = (($env:PATH -split ';') | Where-Object { $_ -notmatch 'WebDrives' }) -join ';'
    }

    Push-Location $RepoRoot
    try {
      python -m robot --variable BROWSER:headlesschrome --listener allure_robotframework:Robot\results\allure-results --outputdir Robot\results Robot\tests
    }
    finally {
      Pop-Location
    }
  }
  finally {
    $env:PATH = $originalPath
  }
}

Write-Host 'Portfolio QA - unified local execution'
Write-Host ("Root: {0}" -f $RepoRoot)

if (-not $SkipCypress) {
  Invoke-Step -Name 'Cypress E2E' -Action { Invoke-CypressSuite }
}

if (-not $SkipPostman) {
  Invoke-Step -Name 'Postman/Newman API' -Action { Invoke-PostmanSuite }
}

if (-not $SkipK6) {
  Invoke-Step -Name 'K6 + WireMock' -Action { Invoke-K6Suite }
}

if (-not $SkipRobot) {
  Invoke-Step -Name 'Robot Framework' -Action { Invoke-RobotSuite }
}

if ($Failures.Count -gt 0) {
  Write-Host ''
  Write-Host 'Failed steps:'
  $Failures | ForEach-Object { Write-Host ("- {0}" -f $_) }
  exit 1
}

Write-Host ''
Write-Host 'All selected suites passed.'
