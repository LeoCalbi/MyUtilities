<#
        .SYNOPSIS
        Powershell utily functions.
#>


# -----------------------------------------------------------------------------
#                              Powershell
# -----------------------------------------------------------------------------

#                               Notes
# -----------------------------------------------------------------------------
# Requires Edit-Item defined in filesystem.psm1

#                               Aliases
# -----------------------------------------------------------------------------
Set-Alias -Name "reloadpwsh" -Value Update-PowershellProfile -Description "Reload Powershell Profile"

Set-Alias -Name "ep" -Value Edit-PowershellProfile -Description "Edit files in the powershell profile directory"

Set-Alias -Name "eph" -Value Edit-PowershellProfile -Description "Edit files in the powershell profile directory"

#                               Functions
# -----------------------------------------------------------------------------
function Edit-PowershellProfile {
    <#
    .SYNOPSIS
        Edit files in the powershell profile directory.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        Edit-Item
    #>
    [CmdletBinding()]
    param()
    Edit-Item (Split-Path -Path $PROFILE)
}

function Update-PowershellProfile {
    <#
    .SYNOPSIS
        Reload the powershell profile.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        pwsh
    #>
    [CmdletBinding()]
    param()
    & $PROFILE
}
