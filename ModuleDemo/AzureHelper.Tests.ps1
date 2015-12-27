if((get-module -Name Pester) -eq $null)
{
    Import-Module $PSScriptRoot\..\lib\Pester -Force -WarningAction SilentlyContinue -ErrorAction Stop -Verbose:$false
}

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$file = "$here\AzureHelper.ps1"
. $file

Describe "AzureHelper" {
    BeforeAll {
        If (Get-Module -Name Azure) {
            Remove-Module Azure -ErrorAction SilentlyContinue
        }
        New-Module -Name Azure -ScriptBlock {
            Function Get-AzureVMImage {

                return @( @{ Description = "Visual Studio" }, @{ Description = $null } );
                        
            }
            Export-ModuleMember -Function *
        } | Import-Module -Verbose
    }

    AfterAll {
        Remove-Module Azure -ErrorAction SilentlyContinue
    }

    It "Should return VS image" {
        $vms = Get-VisualStudioImages
        $vms.Count | Should Be 1
    }
}