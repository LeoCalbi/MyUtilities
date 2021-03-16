<#
        .SYNOPSIS
        Filesystem utily functions.
#>


# -----------------------------------------------------------------------------
#                              Filesystem
# -----------------------------------------------------------------------------

#                               Notes
# -----------------------------------------------------------------------------

#                               Aliases
# -----------------------------------------------------------------------------

Set-Alias -Name "df" -Value Get-Volume -Description "Get Drives Informations"

Set-Alias -Name "e" -Value Edit-Item -Description "Open editor to modify files or folder"

Set-Alias -Name "edit" -Value Edit-Item -Description "Open editor to modify files or folder"

Set-Alias -Name "ff" -Value Find-File -Description "Finds files"

Set-Alias -Name "find" -Value Find-File -Description "Finds files"

Set-Alias -Name "fdir" -Value Find-Directory -Description "Finds directiories"

Set-Alias -Name "finddir" -Value Find-Directory -Description "Finds directiories"

Set-Alias -Name "findreg" -Value Find-FileRegex -Description "Finds files given regex"

Set-Alias -Name "grep" -Value Find-Regex -Description "Finds all occurrence of regex in files"

Set-Alias -Name "grepv" -Value Find-NotRegex -Description "Finds all non-occurrence of regex in files"

Set-Alias -Name "open" -Value Invoke-Item -Description "Open File with default program"

Set-Alias -Name "touch" -Value New-File -Description "Creates an empty file or updates its timestamp"

#                               Functions
# -----------------------------------------------------------------------------

$global:editor = 'code.cmd'
Function New-Dir {
    <#
    .SYNOPSIS
        Creates an empty directory if not already present.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        New-Item
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [string]$Name
    )
    New-Item -Name $Name -ItemType Directory -ErrorAction SilentlyContinue
}
function New-File {
    <#
    .SYNOPSIS
        Creates an empty file or updates its timestamp.
    .Description
        Host-level *nix equivalent to `touch`.
    .INPUTS
        System.Object
    .OUTPUTS
        None
    .LINK
        New-Item
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [string]$Name
    )
    if (Test-Path $Name) {
        (Get-ChildItem $Name).LastWriteTime = Get-Date
    }
    else {
        New-Item -Name $Name -ItemType File
    }
}
function Rename-Extension {
    <#
    .SYNOPSIS
        Rename file extension.
    .INPUTS
        System.Object
    .OUTPUTS
        System.String
    .LINK
        Rename-Item
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $false
        )]
        [string]$Extension
    )
    Rename-Item -NewName { [System.IO.Path]::ChangeExtension($_.Name, $Extension) }
}

function Find-File {
    <#
    .SYNOPSIS
        Finds files.
    .INPUTS
        System.String
    .OUTPUTS
        System.String
    .LINK
        Get-ChildItem
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [string]$Expr,
        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $false
        )]
        [string]$Path = $PWD
    )
    Get-ChildItem -Path $Path -File -Name -Recurse -ErrorAction SilentlyContinue -Include $Expr
}

function Edit-Item {
    <#
    .SYNOPSIS
        Edit files.
    .INPUTS
        System.Object
    .OUTPUTS
        None
    .LINK
        code.cmd
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [string]$Item
    )
    & $editor -g $Item
}

Function Find-FileRegex {
    <#
    .SYNOPSIS
        Finds name files matching regex in given directory.
    .INPUTS
        System.String
    .OUTPUTS
        System.String
    .LINK
        Get-ChildItem
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [string]$Regex,
        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $false
        )]
        [string]$Path = $PWD
    )
    Get-ChildItem -Path $Path -File -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.Name -Match $Regex } | ForEach-Object { $_.FullName.Replace("$Path\", "") }
}

function Find-Regex {
    <#
    .SYNOPSIS
        Finds strings matching regex in files in the given directory.
    .INPUTS
        System.String
    .OUTPUTS
        System.String
    .LINK
        Get-ChildItem
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $false
        )]
        [string]$Regex,
        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $true
        )]
        [string]$Path = "$PWD\*"
    )
    Select-String -Path $Path -Pattern $Regex -Include @args
}

function Find-NotRegex {
    <#
    .SYNOPSIS
        Finds strings not matching regex in files in the given directory.
    .INPUTS
        System.String
    .OUTPUTS
        System.String
    .LINK
        Get-ChildItem
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $false
        )]
        [string]$Regex,
        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $true
        )]
        [string]$Path = "$PWD\*"
    )
    Select-String -Path $Path -Pattern $Regex -NotMatch -Include @args
}

function Find-Directory {
    <#
    .SYNOPSIS
        Finds directories.
    .INPUTS
        System.Object
    .OUTPUTS
        System.String
    .LINK
        Get-ChildItem
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [string]$Expr,
        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $false
        )]
        [string]$Path = $PWD
    )
    Get-ChildItem -Path $Path -Directory -Name -Recurse -ErrorAction SilentlyContinue -Include $Expr
}

function Find-DirectoryRegex {
    <#
    .SYNOPSIS
        Finds directories matching regex.
    .INPUTS
        System.String
    .OUTPUTS
        System.String
    .LINK
        Get-ChildItem
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [string]$Regex,
        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $false
        )]
        [string]$Path = $PWD
    )
    Get-ChildItem -Path $Path -Directory -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.Name -Match $Regex } | ForEach-Object { $_.FullName.Replace("$Path\", "") }
}

Function Get-Links {
    <#
    .SYNOPSIS
        Show Link.
    .INPUTS
        System.String
    .OUTPUTS
        System.String
    .LINK
        Get-ChildItem
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $false
        )]
        [string]$Path = $PWD
    )
    Get-Childitem -Path $Path | Where-Object { $_.LinkType } | Select-Object FullName, LinkType, Target
}

Function Get-TypeDescription {
    <#
    .SYNOPSIS
        Get file extension's description if exist.
    .INPUTS
        System.String
    .OUTPUTS
        System.String
    .LINK
        Get-ItemProperty
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [string]$Path
    )
    $extension = (Get-Item $Path).Extension
    $fileType = (Get-ItemProperty "Registry::HKEY_Classes_root\$extension")."(default)"
    (Get-ItemProperty "Registry::HKEY_Classes_root\$fileType")."(default)"
}
