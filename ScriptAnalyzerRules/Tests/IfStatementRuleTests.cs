using Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic;
using NUnit.Framework;
using ScriptAnalyzerRules;

namespace Tests
{
    [TestFixture]
    public class IfStatementRuleTests : BaseTest
    {        
        [Test]
        public void Should_Find_Error_When_Open_Brace_On_A_New_Line()
        {
            // Act
            var result = Analyze(@"
if (1 -eq 2) 
{
    Write-Host 'Hello'
}
");
            // Assert
            AssertErrorMessage(result, "Open brace should be on the same line as if");
        }

        [Test]
        public void Should_Find_Error_When_There_Is_No_Space_Before_Open_Brace()
        {
            // Act
            var result = Analyze(@"
if (1 -eq 2){
    Write-Host 'Hello'
}
");
            // Assert
            AssertErrorMessage(result, "if statement should have one space before open brace");
        }

        [Test]
        public void Should_Find_Error_When_There_Is_No_Space_After_If()
        {
            // Act
            var result = Analyze(@"
if(1 -eq 2) {
    Write-Host 'Hello'
}
");
            // Assert
            AssertErrorMessage(result, "if statement should have one space after it");
        }

        [Test]
        public void Should_Find_Error_When_Close_Brace_On_The_Same_Line()
        {
            // Act
            var result = Analyze(@"
if (1 -eq 2) {
    Write-Host 'Hello' }
");
            // Assert
            AssertErrorMessage(result, "Close brace should be on a new line");
        }

        [Test]
        public void Should_Not_Find_Error()
        {
            // Act
            var result = Analyze(@"
if (1 -eq 2) {
    Write-Host 'Hello'
}
");
            // Assert
            AssertNoError(result);
        }

        protected override IScriptRule GetRule()
        {
            return new IfStatementRule();
        }
    }
}
