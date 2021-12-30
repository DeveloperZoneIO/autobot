part of 'run.dart';

/// Runs all scripts define in the `scripts` field of the given template.
class ScriptService {
  ScriptService(this.owner);

  final RunCommand owner;

  Map<String, dynamic> runScripts(List<ScriptDef> scripDefs, Map<String, dynamic> variables) {
    var mutableVariables = Map<String, dynamic>.from(variables);

    for (var scriptDef in scripDefs) {
      if (scriptDef.js != null) {
        mutableVariables = JsRunner(owner).run(scriptDef.js!, mutableVariables);
      } else if (scriptDef.shell != null) {
        mutableVariables = ShellRunner(owner).run(scriptDef.shell!, mutableVariables);
      }
    }

    return mutableVariables;
  }
}
