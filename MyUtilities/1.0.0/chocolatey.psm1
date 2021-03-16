<#
        .SYNOPSIS
        Chocolatey utily functions.
#>


# -----------------------------------------------------------------------------
#                               Chocolatey
# -----------------------------------------------------------------------------

#                               Notes
# -----------------------------------------------------------------------------

#                               Aliases
# -----------------------------------------------------------------------------
Set-Alias -Name "chocoinstalled" -Value Get-ChocoInstalledNames -Description "Get chocolatey installed packages names"

#                               Functions
# -----------------------------------------------------------------------------

function Get-ChocoInstalledNames {
    <#
    .SYNOPSIS
        Get chocolatey installed packages names.
    .INPUTS
        None
    .OUTPUTS
        System.String[]
    .LINK
        choco list
    #>
    [CmdletBinding()]
    param()
    choco list -l -r --id-only
}
