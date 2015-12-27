using System.Linq;
using System.Management.Automation.Language;
using Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic;
using NUnit.Framework;

namespace Tests
{
    public abstract class BaseTest
    {
        protected abstract IScriptRule GetRule();

        protected DiagnosticRecord[] Analyze(string code)
        {
            var ast = GetAst(code);
            var result = GetRule().AnalyzeScript(ast, "file.ps1").ToArray();
            return result;
        }

        protected void AssertNoError(DiagnosticRecord[] result)
        {
            Assert.That(result.Length, Is.EqualTo(0));
        }

        private static ScriptBlockAst GetAst(string code)
        {
            Token[] tokens;
            ParseError[] errors;
            ScriptBlockAst ast = Parser.ParseInput(code, out tokens, out errors);
            return ast;
        }

        protected static void AssertErrorMessage(DiagnosticRecord[] result, string message)
        {
            var records = result.Where(r => r.Message.Equals(message)).ToArray();
            Assert.That(records.Length, Is.Not.EqualTo(0), "Can't find - " + message);
        }
    }
}
