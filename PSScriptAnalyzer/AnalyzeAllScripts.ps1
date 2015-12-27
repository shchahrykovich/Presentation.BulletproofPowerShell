cls

if((get-module -Name PSScriptAnalyzer) -eq $null)
{
    Import-Module $PSScriptRoot\..\lib\PSScriptAnalyzer
}

Invoke-ScriptAnalyzer "$PSScriptRoot\Demo.ps1" -Severity Warning | ft -AutoSize