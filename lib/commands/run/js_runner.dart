part of 'run.dart';

/// Runs a javascript script.
class JsRunner {
  Map<String, dynamic> run(String script, Map<String, dynamic> variables) {
    return _run(_prepareScript(script, variables));
  }

  /// Wraps the javascript form template within javascript necessary for:
  /// - proviing a `autobot.inputs` object to the javascript form template
  /// - returning the `autobot.inputs` object
  String _prepareScript(String scriptContent, Map<String, dynamic> variables) {
    final jsConformVariablesMap = variables.unstringifyMapValues();
    final variablesJson = jsonEncode(jsConformVariablesMap);

    return '''
    var autobot = {}
    autobot.variables = JSON.parse('$variablesJson')

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
  Map<String, dynamic> _run(String javascript) {
    final temporaryJsFile = '$pwd/.temporary_script_execution_file.js';
    temporaryJsFile.write(javascript);

    // ignore: deprecated_member_use
    final jsResult = waitFor(
      Script.pipeline([
        Script('node $temporaryJsFile'),
      ]).stdout.text,
      timeout: const Duration(seconds: 5),
    );

    // ignore: deprecated_member_use
    waitFor(Future.delayed(const Duration(milliseconds: 10)));
    delete(temporaryJsFile);

    if (jsResult.isEmpty) {
      throw TellUser((tell) {
        tell(red('Seems like you haven\'t installed node.'));
        tell('Please ensure node is installed in you command line');
      });
    }

    return jsonDecode(jsResult);
  }
}
