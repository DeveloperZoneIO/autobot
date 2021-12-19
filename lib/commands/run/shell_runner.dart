part of 'run.dart';

class ShellRunner extends ScriptRunner {
  ShellRunner(RunCommand owner) : super(owner);

  @override
  Future<Map<String, dynamic>> run(String script, Map<String, dynamic> variables) async {
    await _run(_prepareScript(script, variables));
    return variables;
  }

  String _prepareScript(String scriptContent, Map<String, dynamic> variables) {
    return scriptContent;
  }

  Future<void> _run(String shellScript) async {
    // final temporaryJsFile = '$pwd/.temporary_script_execution_file.js';
    // temporaryJsFile.write(shellScript);

    final jsResult = await Script.pipeline([
      Script(shellScript),
    ]).stdout.lines.forEach((line) => print(line));

    // await Future.delayed(const Duration(milliseconds: 10));
    // delete(temporaryJsFile);

    // return jsonDecode(jsResult);
  }
}
