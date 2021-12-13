part of 'run.dart';

class EnvironmentReader {
  EnvironmentReader(this.owner);

  final RunCommand owner;

  List<Input> readEnvironment() {
    return Platform.environment.entries.map((envPair) {
      return Input(
        key: envPair.key,
        value: envPair.value,
      );
    }).toList();
  }

  List<Input> readEnvironmentFile() {
    final dotEnvPath = 'autobot_env.yaml';
    if (!exists(dotEnvPath)) return [];

    final dotEnvContent = tryRead(dotEnvPath)?.toParagraph();
    if (dotEnvContent == null || dotEnvContent.isEmpty) return [];

    final YamlMap envYaml = loadYaml(dotEnvContent);
    final inputs = <Input>[];

    for (final key in envYaml.keys) {
      if (key is! String) continue;
      final value = envYaml[key];
      if (value is! String) continue;
      inputs.add(Input(key: key, value: value));
    }

    return inputs;
  }
}
