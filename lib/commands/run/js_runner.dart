part of 'run.dart';

class JsRunner extends ScriptRunner {
  JsRunner(RunCommand owner) : super(owner);

  @override
  Future<Map<String, dynamic>> run(String script, Map<String, dynamic> variables) async {
    return _run(_prepareScript(script, variables));
  }

  String _prepareScript(String scriptContent, Map<String, dynamic> variables) {
    return '''
    var autobot = {}
    autobot.variables = JSON.parse('${jsonEncode(variables)}')

    $scriptContent

    var variablesJson = JSON.stringify(autobot.variables)
    console.log(variablesJson) 
    ''';
  }

  Future<Map<String, dynamic>> _run(String javascript) async {
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
