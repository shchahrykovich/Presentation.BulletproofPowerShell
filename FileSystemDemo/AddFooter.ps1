if((get-module -Name Pester) -eq $null)
{
    Import-Module $PSScriptRoot\..\lib\Pester -Force -WarningAction SilentlyContinue -ErrorAction Stop -Verbose:$false
}

function Add-Footer($path, $content) {
    Add-Content $path -Value $content
}

Describe "Add-Footer" {
    # Arrange
    $testPath = "TestDrive:\test.txt"
    <# Equals Join-Path $TestDrive 'test.txt' #>
    Write-Host $TestDrive

    Set-Content $testPath -value "my test text."

    # Act
    Add-Footer $testPath "-Footer"
    $result = Get-Content $testPath

    # Assert
    It "adds a footer" {
        (-join $result) | Should Be "my test text.-Footer"
    }
}