<#
        .SYNOPSIS
        Windows Terminal utility functions.
#>


# -----------------------------------------------------------------------------
#                              Windows Terminal
# -----------------------------------------------------------------------------

#                               Notes
# -----------------------------------------------------------------------------

#                               Aliases
# -----------------------------------------------------------------------------

#                               Functions
# -----------------------------------------------------------------------------
function New-WTShortcut {
    <#
    .SYNOPSIS
        Create new Elevated Windows Terminal shortcut.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        New-Object
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $false
        )]
        [string]$Path = $PWD
    )
    $wshShell = New-Object -comObject WScript.Shell
    $shortcut = $wshShell.CreateShortcut("$Path\Windows Terminal.lnk")
    $shortcut.TargetPath = "$ENV:LOCALAPPDATA\Microsoft\WindowsApps\wt.exe"
    $shortcut.Save()
    $bytes = [System.IO.File]::ReadAllBytes("$Path\Windows Terminal.lnk")
    $bytes[0x15] = $bytes[0x15] -bor 0x20 #set byte 21 (0x15) bit 6 (0x20) ON
    [System.IO.File]::WriteAllBytes("$Path\Windows Terminal.lnk", $bytes)
}
