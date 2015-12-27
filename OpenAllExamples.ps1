if((get-module -Name Pester) -eq $null)
{
    Import-Module $PSScriptRoot\lib\Pester -Force -WarningAction SilentlyContinue -ErrorAction Stop -Verbose:$false
}

ls -Recurse -Filter *.ps1 | ?{ $_.FullName -notmatch "lib" } | % { PSEDIT $_.FullName }