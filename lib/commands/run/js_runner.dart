part of 'run.dart';

/// Runs a javascript script.
class JsRunner extends ScriptRunner {
  JsRunner(RunCommand owner) : super(owner);

  @override
  Future<Map<String, dynamic>> run(
      String script, Map<String, dynamic> variables) async {
    return _run(_prepareScript(script, variables));
  }

  /// Wraps the javascript form template within javascript necessary for:
  /// - proviing a `autobot.inputs` object to the javascript form template
  /// - returning the `autobot.inputs` object
  String _prepareScript(String scriptContent, Map<String, dynamic> variables) {
    return '''
    var autobot = {}
    autobot.variables = JSON.parse('${jsonEncode(variables)}')

    $scriptContent

    var variablesJson = JSON.stringify(autobot.variables)
    console.log(variablesJson) 
    ''';
  }

  /// Runs the javascript.
  /// 1. Create a temporary js file
  /// 2. Execute it running node from the shell
  /// 3. Read the results
  /// 4. Delete the temporary js file
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
