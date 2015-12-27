if((get-module -Name Pester) -eq $null)
{
    Import-Module $PSScriptRoot\..\lib\Pester -Force -WarningAction SilentlyContinue -ErrorAction Stop -Verbose:$false
}

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$file = "$here\Add-Numbers.ps1"
. $file

Describe -Tags "Example" "Add-Numbers" {

    #https://github.com/kmarquette/PesterInAction/blob/master/1%20Basic%20Script/createdesktopshortcut.Tests.ps1
    It "is valid Powershell (Has no script errors)" {
        $contents = Get-Content -Path $file -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors.Count | Should Be 0
    }

    It "adds positive numbers" {
        Add-Numbers 3 3 | Should Be 5
    }

    It "adds negative numbers" {
        Add-Numbers (-2) (-2) | Should Be (-4)
    }

    It "concatenates strings if given strings" {
        Add-Numbers two three | Should Be "twothree"
    }

    Context "TestCase example" {
        $testCase = @(
            @{left = 0; right = 0; expectedResult = 0 }
            @{left = 8; right = 7; expectedResult = 15 }
        )

        It 'Should add numbers' -TestCases $testCase {
            Param ($left, $right, $expectedResult)
            Add-Numbers $left $right | Should Be $expectedResult
        }
    }
}

