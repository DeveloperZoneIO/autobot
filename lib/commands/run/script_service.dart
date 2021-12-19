part of 'run.dart';

class ScriptService {
  ScriptService(this.owner);

  final RunCommand owner;

  Future<Map<String, dynamic>> runScripts(List<ScriptDef> scripDefs, Map<String, dynamic> variables) async {
    var mutableVariables = Map<String, dynamic>.from(variables);

    for (var scriptDef in scripDefs) {
      if (scriptDef.js != null) {
        mutableVariables = await JsRunner(owner).run(scriptDef.js!, mutableVariables);
      } else if (scriptDef.shell != null) {
        mutableVariables = await ShellRunner(owner).run(scriptDef.shell!, mutableVariables);
      }
    }

    return mutableVariables;
  }
}
