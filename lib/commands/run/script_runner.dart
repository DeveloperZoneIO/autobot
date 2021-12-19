part of 'run.dart';

class ScriptRunner {
  ScriptRunner(this.owner);

  final RunCommand owner;

  Future<Map<String, dynamic>> runScripts(List<ScriptDef> scripDefs, Map<String, dynamic> variables) async {
    var mutableVariables = Map<String, dynamic>.from(variables);

    for (var scriptDef in scripDefs) {
      if (scriptDef.js != null) {
        final javascript = _createJavascript(scriptDef.js!, variables);
        final jsVariabels = await _runJavascript(javascript);
        mutableVariables.addAll(jsVariabels);
      }
    }

    return mutableVariables;
  }

  String _createJavascript(String scriptContent, Map<String, dynamic> variables) {
    return '''
    var autobot = {}
    autobot.variables = JSON.parse('${jsonEncode(variables)}')

    $scriptContent

    var variablesJson = JSON.stringify(autobot.variables)
    console.log(variablesJson) 
    ''';
  }

  Future<Map<String, dynamic>> _runJavascript(String javascript) async {
    final temporaryJsFile = '$pwd/.temporary_script_execution_file.js';
    temporaryJsFile.write(javascript);

    final jsResult = await Script.pipeline([
      Script('node $temporaryJsFile'),
    ]).stdout.text;

    await Future.delayed(const Duration(milliseconds: 10));
    delete(temporaryJsFile);

    return jsonDecode(jsResult);
  }
}
