part of 'task.dart';

class ReadStep extends StepNode {
  ReadStep(this.file, {this.required = false});

  final String file;
  final bool required;
}
