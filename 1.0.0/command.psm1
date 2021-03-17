<#
        .SYNOPSIS
        Commands and Function meta-functions.
#>


# -----------------------------------------------------------------------------
#                               Command
# -----------------------------------------------------------------------------

#                               Notes
# -----------------------------------------------------------------------------

#                               Aliases
# -----------------------------------------------------------------------------
Set-Alias -Name "which" -Value Get-CommandSource -Description "Get Command Source path"

#                               Functions
# -----------------------------------------------------------------------------

Function Get-CommandSource {
    <#
    .SYNOPSIS
        Get command source.
    .INPUTS
        System.String
    .OUTPUTS
        System.String
		System.Switch
    .LINK
        Get-Command
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [string]$Name,
        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $false
        )]
        [switch]$All
    )
    if ($All) {
        Get-Command -Name $Name -All | Select-Object -ExpandProperty Source
    }
    else {
        Get-Command -Name $Name | Select-Object -ExpandProperty Source
    }
}
