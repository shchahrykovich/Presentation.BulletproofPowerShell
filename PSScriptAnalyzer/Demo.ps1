$supersecure = convertto-securestring "sdfdsfd" -asplaintext -force

New-Object System.Management.Automation.PSCredential -ArgumentList "username", (ConvertTo-SecureString "really secure" -AsPlainText -Force)

$sneaky = ctss "sneaky convert" -asplainText -force

if (1 -eq 2) {
    Write-Host "Hello World"
}

if (3 -eq 4)
{
    Write-Host "Hello World"
}

if (5 -eq 6) {
    Write-Host "Hello World" }

fucntion get-test {
    return "test";
}