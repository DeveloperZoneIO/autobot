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

  List<Input> readEnvironmentFiles() {
    final inputs = <Input>[];

    for (final filePath in owner.config.environmentFilePaths) {
      inputs.addAll(
        _readSingleEnvironmentFile(filePath),
      );
    }

    return inputs;
  }

  List<Input> _readSingleEnvironmentFile(String path) {
    if (!exists(path)) return [];

    final dotEnvContent = tryRead(path)?.toParagraph();
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
