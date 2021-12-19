part of 'run.dart';

abstract class ScriptRunner {
  ScriptRunner(this.owner);

  final RunCommand owner;

  Future<Map<String, dynamic>> run(String script, Map<String, dynamic> variables);
}
