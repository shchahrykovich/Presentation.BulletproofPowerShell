cls

if((get-module -Name PSScriptAnalyzer) -eq $null)
{
    Import-Module $PSScriptRoot\..\lib\PSScriptAnalyzer
}

$ruleFile = "$PSScriptRoot\ScriptAnalyzerRules-$([guid]::NewGuid().ToString().Substring(0, 5)).dll";
cp -Path "$PSScriptRoot\..\ScriptAnalyzerRules\ScriptAnalyzerRules\bin\Debug\ScriptAnalyzerRules.dll" -Destination $ruleFile -Force

Invoke-ScriptAnalyzer "$PSScriptRoot\Demo.ps1" -Severity Warning -CustomizedRulePath $ruleFile | ft -AutoSize