<#
        .SYNOPSIS
        Unicode and Char utily functions.
#>


# -----------------------------------------------------------------------------
#                               Char
# -----------------------------------------------------------------------------

#                               Aliases
# -----------------------------------------------------------------------------
Set-Alias -Name "unicodechar" -Value Get-CharFromUnicode -Description "Get char representation of Unicode"

Set-Alias -Name "charunicode" -Value Get-UnicodeFromChar -Description "Get Unicode representation of char"

#                               Functions
# -----------------------------------------------------------------------------
function Get-CharFromUnicode {
    <#
    .SYNOPSIS
        Get char representation of Unicode.
    .INPUTS
        Sistem.String
    .OUTPUTS
        System.Char
    .LINK
        System.Char
    #>
    [CmdletBinding()]
    param
    (
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [string] $Code
    )
    if ($Code.StartsWith("U+")) {
        $Code = $Code.Replace("U+", "0x")
    }
    elseif (-not $Code.StartsWith("0x")) {
        $Code = "0x" + $Code
    }
    $num = [int] $Code
    if ((0 -le $num) -and ($num -le 0xFFFF)) {
        return [char]$num
    }

    if ((0x10000 -le $num) -and ($num -le 0x10FFFF)) {
        return [char]::ConvertFromUtf32($num)
    }
    throw "Invalid character Code $Code"
}

function Get-UnicodeFromChar {
    <#
    .SYNOPSIS
        Get hexadecimal representation of Unicode character.
    .INPUTS
        Sistem.Char
    .OUTPUTS
        System.Int
    .LINK
        System.Text.Encoding
    #>
    [CmdletBinding()]
    param
    (
        [char] $Char
    )
    $utf32bytes = [System.Text.Encoding]::UTF32.GetBytes( $Char )
    $codePoint = [System.BitConverter]::ToUint32( $utf32bytes )
    return "0x{0:X}" -f $codePoint
}
