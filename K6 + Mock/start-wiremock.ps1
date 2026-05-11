param(
  [int]$Port = 8080
)

$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$Jar = Join-Path $Root 'wiremock-standalone-3.13.2.jar'

if (-not (Test-Path $Jar)) {
  throw "WireMock jar not found: $Jar"
}

java -jar $Jar --port $Port --root-dir $Root --verbose
