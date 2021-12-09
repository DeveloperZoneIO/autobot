part of 'run.dart';

/// Represents a final key value pair after resolving prompt.
class RunInput {
  RunInput({
    required this.key,
    required this.value,
  });

  final String key;
  final String value;
}

/// represents a input definition from the template yaml file.
class RunTemplateInputDefinition {
  RunTemplateInputDefinition({
    required this.key,
    required this.prompt,
  });

  final String key;
  final String prompt;
}
