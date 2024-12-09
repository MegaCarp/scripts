function Test-PathString {
    <#
    .SYNOPSIS
    Pesterless check for whether a Path string is syntactically correct using Regex.
    #>
    param (
        [string]$PathString
    )

    # Check if the path string is syntactically valid
    if ([System.IO.Path]::IsPathRooted($PathString) -and $PathString -match '^[a-zA-Z]:\\.*') {
        Write-Output "$PathString is a valid path string."
        return $true
    } elseif ($PathString -match '^\\\$$^\$$+(\$$^\$$+)*$') {
        Write-Output "$PathString is a valid path string."
        return $true
    } else {
        Write-Error "$PathString is not a valid path string."
        return $false
    }
}