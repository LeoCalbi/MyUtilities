<#
        .SYNOPSIS
        Process utily functions.
#>


# -----------------------------------------------------------------------------
#                               Process
# -----------------------------------------------------------------------------

#                               Notes
# -----------------------------------------------------------------------------

#                               Aliases
# -----------------------------------------------------------------------------

Set-Alias -Name "pgrep" -Value Get-Process -Description "Get Process Given its name"

Set-Alias -Name "pkill" -Value Stop-ProcessByName -Description "Force kill a Process given its name"

Set-Alias -Name "fuser" -Value Get-ProcessForFile -Description "Get processes using given file"

Set-Alias -Name "top" -Value Get-TopProcess -Description "Get top processes"
#                               Functions
# -----------------------------------------------------------------------------
Function Stop-ProcessByName {
	<#
    .SYNOPSIS
        Stop all process matching the given name.
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
		[string]$Name
	)
	Get-Process $Name -ErrorAction SilentlyContinue | Stop-Process
}

function Get-TopProcess {
	<#
    .SYNOPSIS
        Monitors processes and system resource.
    .INPUTS
        None
    .OUTPUTS
        System.Object
	.LINK
		Get-Process
    #>
	[CmdletBinding()]
	param()
	while ($true) {
		Clear-Host
		# Sort by Working Set size.
		Get-Process | Sort-Object -Descending "WS" | Select-Object -First 30 | Format-Table -Autosize
		Start-Sleep -Seconds 2
	}
}

function Get-ProcessForPort {
	<#
    .SYNOPSIS
        Get processes using given port.
    .INPUTS
        System.Int
    .OUTPUTS
        System.Object[]
	.LINK
		Get-NetTCPConnection
    #>
	[CmdletBinding()]
	param(
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[int]$Port
	)
	Get-Process -Id (Get-NetTCPConnection -LocalPort $Port).OwningProcess
}

function Get-ProcessForFile {
	<#
    .SYNOPSIS
        Get processes using given file.
    .INPUTS
        System.String
    .OUTPUTS
        System.String
	.LINK
		http://stackoverflow.com/questions/39148304/fuser-equivalent-in-powershell/39148540#39148540
    #>
	[CmdletBinding()]
	param(
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$Filename
	)
	$file = Resolve-Path $Filename
	Write-Output "Looking for processes using $file"
	foreach ( $Process in (Get-Process)) {
		foreach ( $Module in $Process.Modules) {
			if ( $Module.FileName -like "$file*" ) {
				$Process | Select-Object Id, Path
			}
		}
	}
}
