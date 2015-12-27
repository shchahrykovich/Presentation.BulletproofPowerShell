if((get-module -Name Pester) -eq $null)
{
    Import-Module $PSScriptRoot\..\lib\Pester -Force -WarningAction SilentlyContinue -ErrorAction Stop -Verbose:$false
}

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$file = "$here\AzureHelper.ps1"
. $file

Describe "AzureHelper" {

    Context "When Get-AzureVMImage returns one VS image and one image with empty description" {
        Mock Get-AzureVMImage {return @( @{ Description = "Visual Studio" }, @{ Description = $null })}

        $vms = Get-VisualStudioImages

        It "Should return one image" {            
            $vms.Count | Should Be 1
        }
    }

    Context "When Get-AzureVMImage returns 3 images" {
        Mock Get-AzureVMImage {return @( @{ Description = "Visual Studio" }, @{ Description = "Visual Studio" }, @{ Description = "Visual Studio" })}

        $vms = Get-VisualStudioImages

        It "Should return 3 images" {
            $vms.Count | Should Be 3
        }
    }
}