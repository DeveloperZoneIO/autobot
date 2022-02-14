part of 'run.dart';

/// Runs a shell script.
class ShellRunner with TextRenderable {
  run(String script, Map<String, dynamic> variables) {
    renderData.addAll(variables);
    _run(_prepareScript(script));
    return variables;
  }

  String _prepareScript(String scriptContent) {
    return render(scriptContent);
  }

  void _run(String shellScript) {
    // ignore: deprecated_member_use
    waitFor(
      Script.pipeline([
        Script(shellScript),
      ]).stdout.lines.forEach((line) => tell(line)),
    );
  }
}
