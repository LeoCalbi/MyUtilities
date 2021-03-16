<#
        .SYNOPSIS
        Navigation utily functions.
#>


# -----------------------------------------------------------------------------
#                               Navigation
# -----------------------------------------------------------------------------

#                               Notes
# -----------------------------------------------------------------------------

#                               Aliases
# -----------------------------------------------------------------------------
Set-Alias -Name "~" -Value Set-LocationHome -Description "Goes to user home directory"

Set-Alias -Name "cd-" -Value Set-LocationLast -Description "Goes to last used directory"

Set-Alias -Name ".." -Value Set-LocationUp -Description "Goes up a directory"

Set-Alias -Name "..." -Value Set-LocationUp2 -Description "Goes up two directories"

Set-Alias -Name "...." -Value Set-LocationUp3 -Description "Goes up three directories"

Set-Alias -Name "....." -Value Set-LocationUp4 -Description "Goes up four directories"

Set-Alias -Name "......" -Value Set-LocationUp5 -Description "Goes up five directories"

Set-Alias -Name "dls" -Value Set-LocationDownloads -Description "Navigates to Downloads directory."

Set-Alias -Name "docs" -Value Set-LocationDocuments -Description "Navigates to Documents directory."

Set-Alias -Name "dt" -Value Set-LocationDesktop -Description "Navigates to Desktop directory."

Set-Alias -Name "repos" -Value Set-LocationDevelopement -Description "Navigates to Developement directory."

#                               Functions
# -----------------------------------------------------------------------------

$DevelopementDir = "Developement"
$DownloadDir = "Download"
$LocationHistoryForward = $false

function Set-LocationHome {
    <#
    .SYNOPSIS
        Goes to user home directory.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Low'
    )]
    param()
    begin {
        $path = $HOME
        Write-Verbose "Destination set to $path"
    }
    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationLast {
    <#
    .SYNOPSIS
        Goes to last used directory.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Low'
    )]
    param()

    begin {
        if ($LocationHistoryForward) {
            $path = "+"
        }
        else {
            $path = "-"
        }
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            $LocationHistoryForward = $true - $LocationHistoryForward
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationUp {
    <#
    .SYNOPSIS
        Goes up a directory.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Low'
    )]
    param()

    begin {
        $path = Convert-Path -Path ".."
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationUp2 {
    <#
    .SYNOPSIS
        Goes up two directories.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Low'
    )]
    param()

    begin {
        $path = Convert-Path -Path "../.."
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationUp3 {
    <#
    .SYNOPSIS
        Goes up three directories.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Low'
    )]
    param()

    begin {
        $path = Convert-Path -Path "../../.."
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationUp4 {
    <#
    .SYNOPSIS
        Goes up four directories.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Low'
    )]
    param()

    begin {
        $path = Convert-Path -Path "../../../.."
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationUp5 {
    <#
    .SYNOPSIS
        Goes up five directories.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Low'
    )]
    param()

    begin {
        $path = Convert-Path -Path "../../../../.."
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}
function Set-LocationDocuments {
    <#
    .SYNOPSIS
        Navigates to Documents directory.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Low'
    )]
    param()

    begin {
        $path = Convert-Path -Path ([Environment]::GetFolderPath("MyDocuments"))
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationDownloads {
    <#
    .SYNOPSIS
        Navigates to Downloads directory.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Low'
    )]
    param()

    begin {
        $path = Convert-Path -Path "${HOME}\$DownloadDir"
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationDesktop {
    <#
    .SYNOPSIS
        Navigates to Desktop directory.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Low'
    )]
    param()

    begin {
        $path = Convert-Path -Path ([Environment]::GetFolderPath("Desktop"))
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationPowershellConf {
    <#
    .SYNOPSIS
        Navigates to Powershell's profile location.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        https://devblogs.microsoft.com/scripting/understanding-the-six-powershell-profiles/
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Low'
    )]
    param()

    begin {
        $path = Split-Path -Path $Profile
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationDevelopement {
    <#
    .SYNOPSIS
        Navigates to Developement directory.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Low'
    )]
    param()

    begin {
        $path = Convert-Path -Path "${HOME}\$DevelopementDir"
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}
