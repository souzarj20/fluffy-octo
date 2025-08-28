#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Merges JSON configuration files for ASP.NET Core applications

.DESCRIPTION
    This script merges multiple JSON configuration files, handling environment-specific overrides
    and maintaining proper JSON structure.

.PARAMETER BaseFile
    The base configuration file (e.g., appsettings.json)

.PARAMETER OverrideFile  
    The override configuration file (e.g., appsettings.Development.json)

.PARAMETER OutputFile
    The output file for the merged configuration (optional)

.PARAMETER ShowPreview
    Display the merged result without writing to file

.EXAMPLE
    ./merge-config.ps1 -BaseFile appsettings.json -OverrideFile appsettings.Development.json -ShowPreview

.EXAMPLE
    ./merge-config.ps1 -BaseFile appsettings.json -OverrideFile appsettings.Development.json -OutputFile merged-appsettings.json
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$BaseFile,
    
    [Parameter(Mandatory=$true)]
    [string]$OverrideFile,
    
    [Parameter(Mandatory=$false)]
    [string]$OutputFile,
    
    [Parameter(Mandatory=$false)]
    [switch]$ShowPreview
)

function Merge-JsonObjects {
    param(
        [PSCustomObject]$Base,
        [PSCustomObject]$Override
    )
    
    $merged = $Base.PSObject.Copy()
    
    foreach ($property in $Override.PSObject.Properties) {
        if ($merged.PSObject.Properties.Name -contains $property.Name) {
            if ($property.Value -is [PSCustomObject] -and $merged.($property.Name) -is [PSCustomObject]) {
                # Recursively merge nested objects
                $merged.($property.Name) = Merge-JsonObjects -Base $merged.($property.Name) -Override $property.Value
            } else {
                # Override the value
                $merged.($property.Name) = $property.Value
            }
        } else {
            # Add new property
            $merged | Add-Member -Type NoteProperty -Name $property.Name -Value $property.Value
        }
    }
    
    return $merged
}

try {
    # Validate input files exist
    if (!(Test-Path $BaseFile)) {
        throw "Base file '$BaseFile' not found"
    }
    
    if (!(Test-Path $OverrideFile)) {
        throw "Override file '$OverrideFile' not found"
    }
    
    Write-Host "Merging configuration files..." -ForegroundColor Green
    Write-Host "Base file: $BaseFile" -ForegroundColor Cyan
    Write-Host "Override file: $OverrideFile" -ForegroundColor Cyan
    
    # Read and parse JSON files
    $baseContent = Get-Content $BaseFile -Raw | ConvertFrom-Json
    $overrideContent = Get-Content $OverrideFile -Raw | ConvertFrom-Json
    
    # Perform the merge
    $mergedContent = Merge-JsonObjects -Base $baseContent -Override $overrideContent
    
    # Convert back to JSON with proper formatting
    $mergedJson = $mergedContent | ConvertTo-Json -Depth 10 -Compress:$false
    
    if ($ShowPreview) {
        Write-Host "`nMerged Configuration Preview:" -ForegroundColor Yellow
        Write-Host "================================" -ForegroundColor Yellow
        Write-Host $mergedJson -ForegroundColor White
    }
    
    if ($OutputFile) {
        $mergedJson | Out-File -FilePath $OutputFile -Encoding UTF8
        Write-Host "`nMerged configuration saved to: $OutputFile" -ForegroundColor Green
    }
    
    if (!$ShowPreview -and !$OutputFile) {
        Write-Host "`nMerged Configuration:" -ForegroundColor Yellow
        Write-Host "===================" -ForegroundColor Yellow
        Write-Host $mergedJson -ForegroundColor White
    }
    
} catch {
    Write-Error "Error merging configuration files: $($_.Exception.Message)"
    exit 1
}

Write-Host "`nMerge completed successfully!" -ForegroundColor Green