<#
        .SYNOPSIS
        Environment utily functions.
#>


# -----------------------------------------------------------------------------
#                               Environment
# -----------------------------------------------------------------------------

#                               Notes
# -----------------------------------------------------------------------------
# Requires PSCX for the Add-PathVariable function

#                               Aliases
# -----------------------------------------------------------------------------
Set-Alias -Name "export" -Value Set-EnvironmentVariable -Description "Set Environment Variable to given Value"

Set-Alias -Name "path" -Value Get-PathVariable -Description "Get Path Variables"

Set-Alias -Name "env" -Value Get-Environment -Description "Get Enviroment Variables"

Set-Alias -Name "envvar" -Value Get-EnvironmentVariable -Description "Get Enviroment Variable"

Set-Alias -Name "renvvar" -Value Renove-EnvironmentVariable -Description " Remove an enviroment variable if present"

#                               Functions
# -----------------------------------------------------------------------------
Function Get-Environment {
    <#
    .SYNOPSIS
        Prints each Env: entry on a separate lines.
    .INPUTS
        None
    .OUTPUTS
        System.String[]
    #>
    [CmdletBinding()]
    param()
    Get-ChildItem -Path "Env:"
}

Function Get-EnvironmentVariable {
    <#
    .SYNOPSIS
        Prints all Env: entries that match the given name.
    .INPUTS
        System.String
    .OUTPUTS
        System.String[]
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [string]$Name
    )
    Get-Item -Path "Env:$Name" -ErrorAction SilentlyContinue
}

Function Set-EnvironmentVariable {
    <#
    .SYNOPSIS
        Creates a new enviroment variable or updates its value.
    .INPUTS
        System.String
		System.String[]
        System.Switch
        System.EnvironmentVariableTarget
    .OUTPUTS
        None
    .LINK
        Add-PathVariable
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $false
        )]
        [string]$Name,

        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [string]$Value,

        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $false
        )]
        [switch]$Prepend,

        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $false
        )][ValidateSet("Process", "User", "Machine")]
        [string]$Target = "Process"
    )
    Add-PathVariable -Name $Name -Value $Value -Prepend:$Prepend -Target $Target;
}
Function Remove-EnviromentVariable {
    <#
    .SYNOPSIS
        Remove an enviroment variable if present.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        Remove-Item
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [string]$name
    )
    Remove-Item -Path "Env:$name"
}
