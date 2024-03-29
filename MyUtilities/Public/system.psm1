<#
        .SYNOPSIS
        System utility functions.
#>


# -----------------------------------------------------------------------------
#                               System
# -----------------------------------------------------------------------------

#                               Notes
# -----------------------------------------------------------------------------

#                               Aliases
# -----------------------------------------------------------------------------
Set-Alias -Name "uptime" -Value Get-Uptime -Description "Get Computer UpTime"

Set-Alias -Name "reboot" -Value Restart-Computer -Description "Reboot the computer"

Set-Alias -Name "restart" -Value Restart-Computer -Description "Reboot the computer"

Set-Alias -Name "shutdown" -Value Stop-Computer -Description "Turns off the computer"

Set-Alias -Name "settings" -Value Get-Settings -Description "Open System Settings"
#                               Functions
# -----------------------------------------------------------------------------
function Get-Settings {
  [CmdletBinding()]
  param()
  Start-Process ms-settings:
}

function Get-WindowsBuild {
  [CmdletBinding()]
  param()
  return [Environment]::OSVersion
}
function Get-SerialNumber {
  [CmdletBinding()]
  param()
  Get-CimInstance -ClassName Win32_BIOS | Select-Object SerialNumber
}
function Test-Administrator {
  [CmdletBinding()]
  param()
  return (New-Object Security.Principal.WindowsPrincipal ([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function Test-System {
  <#
  .SYNOPSIS
      Check and fix system files.
  .OUTPUTS
      System.String
  .LINK
      DISM, SFC
  #>
  [CmdletBinding()]
  param()
  Write-Host "$(Get-Date) - DISM /Online /Cleanup-Image /StartComponentCleanup" -NoNewLine -ForegroundColor yellow
  DISM /Online /Cleanup-Image /StartComponentCleanup
  Write-Host "$(Get-Date) - DISM /Online /Cleanup-Image /RestoreHealth" -NoNewLine -ForegroundColor yellow
  DISM /Online /Cleanup-Image /RestoreHealth
  Write-Host "$(Get-Date) - SFC /scannow" -NoNewLine -ForegroundColor yellow
  SFC /scannow
}