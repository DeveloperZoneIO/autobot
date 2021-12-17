part of 'run.dart';

class ScriptRunner {
  ScriptRunner(this.owner);

  final RunCommand owner;

  Future<List<Input>> runScripts(List<ScriptDef> scripDefs, List<Input> inputs) async {
    var mutableInputs = List<Input>.from(inputs);

    for (var scriptDef in scripDefs) {
      if (scriptDef.js != null) {
        mutableInputs = await _runJavascript(scriptDef.js!, inputs);
      }
    }

    return List.from(mutableInputs);
  }

  Future<List<Input>> _runJavascript(String javascript, List<Input> inputs) async {
    final jsTemporaryFilePath = '$pwd/.temporary_script_execution_file.js';

    // Define autobot object in javascript
    jsTemporaryFilePath.write('''
    var autobot = {}
    autobot.inputs = {}
    ''');

    // Fill autobot object with inputs
    for (final input in inputs) {
      final jsAddInputToAoutobotObject = 'autobot.inputs.${input.key} = "${input.value}"';
      jsTemporaryFilePath.append(jsAddInputToAoutobotObject);
    }

    // Add custom js script from template
    jsTemporaryFilePath.append(javascript);

    // Return autobot inputs
    jsTemporaryFilePath.append('''
    var joineAutobotInputs = ''
    for (key in autobot.inputs) { 
      joineAutobotInputs = joineAutobotInputs + ';' + key + '=' + autobot.inputs[key]
    }
    console.log(joineAutobotInputs) 
    ''');

    // runs the temporary script file
    final scriptOutput = await Script.pipeline([
      Script('node $jsTemporaryFilePath'),
    ]).stdout.text;

    // Parse the inputs from javascript
    final processeInputs = scriptOutput //
        .split(';')
        .where((keyValue) => keyValue.contains('='))
        .map((keyValueString) {
      final pair = keyValueString.split('=');
      return Input(
        key: pair[0],
        value: pair[1],
      );
    }).toList();

    await Future.delayed(const Duration(milliseconds: 10));
    delete(jsTemporaryFilePath);

    return processeInputs;
  }
}
