<#
.SYNOPSIS
    Packages the skin as Installer\rainmeter-mqtt-power-<version>.rmskin.

.DESCRIPTION
    Builds the same format as Rainmeter's Skin Packager: a zip containing
    RMSKIN.ini, Skins\rainmeter-mqtt-power\... and Plugins\32bit|64bit\...,
    followed by a 16-byte footer (zip size as Int64, a flags byte, then
    "RMSKIN\0").

    Version and Author are read from [Metadata] in rainmeter-mqtt-power.ini.
    Settings.inc is listed in VariableFiles, so reinstalling or upgrading
    keeps the user's broker, topic and login.

.EXAMPLE
    .\build.ps1
#>
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression

$skin = 'rainmeter-mqtt-power'
$source = Join-Path $PSScriptRoot $skin
$plugins = Join-Path $PSScriptRoot 'Plugins'
$ini = Join-Path $source 'rainmeter-mqtt-power.ini'

function Get-Metadata([string]$key) {
    $match = Select-String -LiteralPath $ini -Pattern "^$key=(.+)$" | Select-Object -First 1
    if (-not $match) { throw "No $key= found in $ini" }
    $match.Matches[0].Groups[1].Value.Trim()
}
$version = Get-Metadata 'Version'
$author = Get-Metadata 'Author'

# Refuse to package credentials.
$settings = Get-Content -LiteralPath (Join-Path $source '@Resources\Settings.inc')
if ($settings -match '^Mqtt(User|Password)=\S') {
    throw 'Settings.inc contains an MQTT username or password. Clear them before building.'
}

$rmskinIni = @"
[rmskin]
Name=$skin
Author=$author
Version=$version
LoadType=Skin
Load=$skin\rainmeter-mqtt-power.ini
VariableFiles=$skin\@Resources\Settings.inc
MinimumRainmeter=4.5.23.3836
MinimumWindows=5.1
"@

$installer = Join-Path $PSScriptRoot 'Installer'
New-Item -ItemType Directory -Force -Path $installer | Out-Null
$out = Join-Path $installer "$skin-$version.rmskin"
if (Test-Path -LiteralPath $out) { Remove-Item -LiteralPath $out }

# Zip entry name -> source file. The MqttClient plugin ships with the skin.
$entries = [ordered]@{}
foreach ($file in Get-ChildItem -LiteralPath $source -Recurse -File -Force) {
    $entries["Skins/$skin/" + $file.FullName.Substring($source.Length + 1).Replace('\', '/')] = $file.FullName
}
foreach ($file in Get-ChildItem -LiteralPath $plugins -Recurse -File -Filter *.dll) {
    $entries['Plugins/' + $file.FullName.Substring($plugins.Length + 1).Replace('\', '/')] = $file.FullName
}

$stream = [IO.File]::Open($out, [IO.FileMode]::CreateNew)
try {
    $zip = New-Object IO.Compression.ZipArchive($stream, [IO.Compression.ZipArchiveMode]::Create, $true)
    try {
        $entry = $zip.CreateEntry('RMSKIN.ini')
        $writer = New-Object IO.StreamWriter($entry.Open(), (New-Object Text.ASCIIEncoding))
        $writer.Write($rmskinIni)
        $writer.Dispose()

        foreach ($name in $entries.Keys) {
            $entry = $zip.CreateEntry($name)
            $in = [IO.File]::OpenRead($entries[$name])
            $to = $entry.Open()
            $in.CopyTo($to)
            $to.Dispose()
            $in.Dispose()
        }
    } finally {
        $zip.Dispose()
    }

    $zipSize = $stream.Length
    [byte[]]$footer = [BitConverter]::GetBytes([Int64]$zipSize) + [byte]0 + [Text.Encoding]::ASCII.GetBytes("RMSKIN`0")
    $stream.Write($footer, 0, $footer.Length)
} finally {
    $stream.Dispose()
}

Write-Host "Built $out" -ForegroundColor Green
