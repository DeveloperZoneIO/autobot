import 'package:autobot/common/string_util.dart';

class MissingConfigFile implements Exception {
  @override
  String toString() => '''
  No "autobot_config.yaml" found in working directory.
  Please add a "autobot_config.yaml" to the current working directory.
  '''
      .stripMargin();
}

class MissingPubspec implements Exception {
  @override
  String toString() => 'Autobot is missing a pubspec.yaml file.';
}

class MissingYamlField implements Exception {
  MissingYamlField({required this.field, required this.file});
  final String field;
  final String file;

  @override
  String toString() => '$file.yaml file is missing the "$field" property.';
}
