import 'package:autobot/common/exceptions.dart';
import 'package:yaml/yaml.dart';

class ConfigFileValiator {
  static List<MissingYamlField> checkConfigFileContent(YamlMap config) {
    final issues = <MissingYamlField>[];

    if (!config.containsKey('config')) {
      issues.add(MissingYamlField(field: 'config', file: 'config.yaml'));
    }

    return issues;
  }
}
