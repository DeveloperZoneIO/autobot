part of 'run.dart';

class TemplateOutputDefinition {
  TemplateOutputDefinition({
    required this.path,
    required this.canWrite,
    required this.content,
  });

  final String path;
  final String canWrite;
  final String content;
}
