part of 'run.dart';

/// Runs a shell script.
class ShellRunner extends ScriptRunner {
  ShellRunner(RunCommand owner) : super(owner);

  @override
  Map<String, dynamic> run(String script, Map<String, dynamic> variables) {
    _run(_prepareScript(script, variables));
    return variables;
  }

  String _prepareScript(String scriptContent, Map<String, dynamic> variables) {
    return scriptContent;
  }

  void _run(String shellScript) {
    waitFor(
      Script.pipeline([
        Script(shellScript),
      ]).stdout.lines.forEach((line) => tell(line)),
    );
  }
}
