<#
        .SYNOPSIS
        Installed Modules utily functions.
#>


# -----------------------------------------------------------------------------
#                               Module
# -----------------------------------------------------------------------------

#                               Notes
# -----------------------------------------------------------------------------
# Requires Test-Administrator defined in system.psm1

#                               Aliases
# -----------------------------------------------------------------------------
Set-Alias -Name "modules" -Value Get-AllVersionsAllModules -Description "Shows all versions of a given module"
Set-Alias -Name "cleanmods" -Value Uninstall-AllOldVersionsAllModules -Description "Uninstall all versions of all modules which aren't the latest one"

#                               Functions
# -----------------------------------------------------------------------------
function Get-AllModuleVersions {
    <#
    .SYNOPSIS
        Shows all versions of a given module.
    .INPUTS
        System.String
    .OUTPUTS
        System.String
    .LINK
        Get-InstalledModule
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [string]$Mod
    )
    $latest = Get-InstalledModule $Mod
    $specificmods = Get-InstalledModule $Mod -allversions
    Write-Host "$($specificmods.count) versions found of [ $($Mod) ]"
    foreach ($sm in $specificmods) {
        if ($sm.version -eq $latest.version)
        { $color = "green" }
        else
        { $color = "magenta" }
        Write-Host " $($sm.name) - $($sm.version) [highest installed is $($latest.version)]" -foregroundcolor $color
    }
}
function Uninstall-AllOldVersion {
    <#
    .SYNOPSIS
        Uninstall all old versions of a given module.
    .INPUTS
        System.String
    .OUTPUTS
        System.String
    .LINK
        Uninstall-Module
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [string]$Mod
    )
    if (Test-Administrator) {
        $latest = Get-InstalledModule $Mod
        $specificmods = Get-InstalledModule $Mod -allversions
        Write-Host "$($specificmods.count) versions found of [ $($Mod) ]"
        foreach ($sm in $specificmods) {
            if ($sm.version -ne $latest.version) {
                Write-Host "uninstalling $($sm.name) - $($sm.version) [latest is $($latest.version)]"
                $sm | Uninstall-Module -force
            }
        }
    }
    else {
        Write-Error -Message "Must be Administrator to uninstall modules, retry as Admin"
    }
}

function Get-AllVersionsAllModules {
    <#
    .SYNOPSIS
        Shows all versions of all installed modules.
    .INPUTS
        System.String
    .OUTPUTS
        System.String
    .LINK
        Get-AllModuleVersions
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $true
        )]
        [string]$Mod
    )
    if ($Mod) {
        Get-AllModuleVersions($Mod)
    }
    else {
        $mods = Get-InstalledModule
        foreach ($module in $mods) {
            Get-AllModuleVersions($module.Name)
        }
    }
}
function Uninstall-AllOldVersionsAllModules {
    <#
    .SYNOPSIS
        Uninstall all versions of all modules which aren't the latest one.
    .INPUTS
        System.String
    .OUTPUTS
        System.String
    .LINK
        Uninstall-AllOldVersion
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $true
        )]
        [string]$Mod
    )
    if (Test-Administrator) {
        if ($Mod) {
            Uninstall-AllOldVersion($Mod)
        }
        else {
            $mods = Get-InstalledModule
            foreach ($module in $mods) {
                Uninstall-AllOldVersion($module.Name)
            }
        }
    }
    else {
        Write-Error -Message "Must be Administrator to uninstall modules, retry as Admin"
    }
}
