part of 'task.dart';

class WriteStep extends StepNode {
  WriteStep(
    this.file,
    this.content, {
    this.writeMethod = 'default',
    this.enabled = 'yes',
    this.extendAt = 'bottom',
  }) : super();

  final String file;
  final String content;
  final String writeMethod;
  final String enabled;
  final String extendAt;
}
