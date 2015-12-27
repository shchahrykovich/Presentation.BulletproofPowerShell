if((get-module -Name Azure) -ne $null)
{
    Import-Module Azure
}

function Get-VisualStudioImages() {
    return Get-AzureVMImage | ?{ $_.Description -ne $null -and $_.Description.Contains("Visual Studio") }
}