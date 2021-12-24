part of 'run.dart';

/// Base class for running any type of script.
abstract class ScriptRunner {
  ScriptRunner(this.owner);

  final RunCommand owner;

  Future<Map<String, dynamic>> run(
      String script, Map<String, dynamic> variables);
}
