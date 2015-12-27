using System;
using System.Collections.Generic;
using System.Management.Automation.Language;
using Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic;
using System.ComponentModel.Composition;
using System.Diagnostics;
using System.Linq;

namespace ScriptAnalyzerRules
{
    [Export(typeof(IScriptRule))]
    public class IfStatementRule : IScriptRule
    {
        public IEnumerable<DiagnosticRecord> AnalyzeScript(Ast ast, string fileName)
        {
            IEnumerable<IfStatementAst> statements =
                ast.FindAll(testAst => testAst is IfStatementAst, true).OfType<IfStatementAst>().ToArray();

            foreach (IfStatementAst statement in statements)
            {
                var start = statement.Extent.StartScriptPosition.Line.Trim();
                if (!start.EndsWith("{"))
                {
                    var record = CreateRecord(fileName, statement, "Open brace should be on the same line as if");
                    yield return record;
                }

                if (!start.EndsWith(" {"))
                {
                    var record = CreateRecord(fileName, statement, "if statement should have one space before open brace");
                    yield return record;
                }

                if (!start.StartsWith("if (", StringComparison.OrdinalIgnoreCase))
                {
                    var record = CreateRecord(fileName, statement, "if statement should have one space after it");
                    yield return record;
                }

                if (!statement.Extent.EndScriptPosition.Line.Trim().Equals("}"))
                {
                    var record = CreateRecord(fileName, statement, "Close brace should be on a new line");
                    yield return record;
                }
            }
        }

        private DiagnosticRecord CreateRecord(string fileName, IfStatementAst statement, string message)
        {
            var record = new DiagnosticRecord(message,
                statement.Extent,
                GetName(),
                DiagnosticSeverity.Warning,
                fileName);
            return record;
        }

        public string GetName()
        {
            return "IfStatementRule";
        }

        public string GetCommonName()
        {
            return "IfStatementRule";
        }

        public string GetDescription()
        {
            return "IfStatementRule";
        }

        public SourceType GetSourceType()
        {
            return SourceType.Managed;
        }

        public RuleSeverity GetSeverity()
        {
            return RuleSeverity.Warning;
        }

        public string GetSourceName()
        {
            return "SourceName";
        }
    }
}
