part of 'run.dart';

/// represents a input definition from the template yaml file.
class TemplateInputDefinition {
  TemplateInputDefinition({
    required this.key,
    required this.prompt,
  });

  final String key;
  final String prompt;
}
