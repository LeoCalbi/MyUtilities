<#
        .SYNOPSIS
        Network utily functions.
#>


# -----------------------------------------------------------------------------
#                              Networking
# -----------------------------------------------------------------------------

#                               Notes
# -----------------------------------------------------------------------------

#                               Aliases
# -----------------------------------------------------------------------------
Set-Alias -Name "flushdns" -Value Clear-DnsClientCache -Description "Flushes the DNS cache."

Set-Alias -Name "ips" -Value Get-IPS -Description "Gets all IP addresses."

Set-Alias -Name "publicip" -Value Get-PublicIP -Description "Gets external IP address."

Set-Alias -Name "GET" -Value Invoke-RestMethodGet -Description "Sends a GET http request."

Set-Alias -Name "HEAD" -Value Invoke-RestMethodHead -Description "Sends a HEAD http request."

Set-Alias -Name "POST" -Value Invoke-RestMethodPost -Description "Sends a POST http request."

Set-Alias -Name "PUT" -Value Invoke-RestMethodPut -Description "Sends a PUT http request."

Set-Alias -Name "DELETE" -Value Invoke-RestMethodDelete -Description "Sends a DELETE http request."

Set-Alias -Name "TRACE" -Value Invoke-RestMethodTrace -Description "Sends a TRACE http request."

Set-Alias -Name "OPTIONS" -Value Invoke-RestMethodOptions -Description "Sends an OPTIONS http request."
#                               Functions
# -----------------------------------------------------------------------------
function Get-IPS {
    <#
    .SYNOPSIS
        Gets all IP addresses.
    .INPUTS
        None
    .OUTPUTS
        Microsoft.PowerShell.Commands.Internal.Format
        System.String[]
    .LINK
        Get-NetIPAddress
    #>
    [CmdletBinding()]
    param()
    Get-NetIPAddress | Where-Object { $_.AddressState -eq "Preferred" } | Sort-object IPAddress | Format-Table -Wrap -AutoSize
}

function Get-PublicIP {
    <#
    .SYNOPSIS
        Gets external IP address.
    .INPUTS
        None
    .OUTPUTS
        Microsoft.PowerShell.Commands.MatchInfo
        System.Boolean
        System.String
    .LINK
        Invoke-RestMethod
    .LINK
        https://github.com/chubin/awesome-console-services
    #>
    [CmdletBinding()]
    param()
    Invoke-RestMethod http://ipinfo.io/json | Select-Object -exp ip
}

function Invoke-RestMethodGet {
    <#
    .SYNOPSIS
        Sends a GET http request.
    .INPUTS
        System.Object
    .OUTPUTS
        System.Object
    .LINK
        Invoke-RestMethod
    #>
    [CmdletBinding()]
    param()
    Invoke-RestMethod -Method GET @args
}

function Invoke-RestMethodHead {
    <#
    .SYNOPSIS
        Sends a HEAD http request.
    .INPUTS
        System.Object
    .OUTPUTS
        System.Object
    .LINK
        Invoke-RestMethod
    #>
    [CmdletBinding()]
    param()
    Invoke-RestMethod -Method HEAD @args
}

function Invoke-RestMethodPost {
    <#
    .SYNOPSIS
        Sends a POST http request.
    .INPUTS
        System.Object
    .OUTPUTS
        System.Object
    .LINK
        Invoke-RestMethod
    #>
    [CmdletBinding()]
    param()
    Invoke-RestMethod -Method POST @args
}

function Invoke-RestMethodPut {
    <#
    .SYNOPSIS
        Sends a PUT http request.
    .INPUTS
        System.Object
    .OUTPUTS
        System.Object
    .LINK
        Invoke-RestMethod
    #>
    [CmdletBinding()]
    param()
    Invoke-RestMethod -Method PUT @args
}

function Invoke-RestMethodDelete {
    <#
    .SYNOPSIS
        Sends a DELETE http request.
    .INPUTS
        System.Object
    .OUTPUTS
        System.Object
    .LINK
        Invoke-RestMethod
    #>
    [CmdletBinding()]
    param()
    Invoke-RestMethod -Method DELETE @args
}

function Invoke-RestMethodTrace {
    <#
    .SYNOPSIS
        Sends a TRACE http request.
    .INPUTS
        System.Object
    .OUTPUTS
        System.Object
    .LINK
        Invoke-RestMethod
    #>
    [CmdletBinding()]
    param()
    Invoke-RestMethod -Method TRACE @args
}

function Invoke-RestMethodOptions {
    <#
    .SYNOPSIS
        Sends an OPTIONS http request.
    .INPUTS
        System.Object
    .OUTPUTS
        System.Int64
        System.String
        System.Xml.XmlDocument
        PSObject
    .LINK
        Invoke-RestMethod
    #>
    [CmdletBinding()]
    param()
    Invoke-RestMethod -Method OPTIONS @args
}
