part of 'run.dart';

/// Runs a shell script.
class ShellRunner extends ScriptRunner with TextRenderable {
  ShellRunner(RunCommand owner) : super(owner);

  @override
  Map<String, dynamic> run(String script, Map<String, dynamic> variables) {
    renderVariables.addAll(variables);
    _run(_prepareScript(script));
    return variables;
  }

  String _prepareScript(String scriptContent) {
    return render(scriptContent);
  }

  void _run(String shellScript) {
    waitFor(
      Script.pipeline([
        Script(shellScript),
      ]).stdout.lines.forEach((line) => tell(line)),
    );
  }
}
