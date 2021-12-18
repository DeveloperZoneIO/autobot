part of 'run.dart';

class EnvironmentReader {
  EnvironmentReader(this.owner);

  final RunCommand owner;

  Map<String, String> readEnvironment() => Platform.environment;

  Map<String, dynamic> readEnvironmentFiles() {
    final variables = <String, dynamic>{};

    for (final filePath in owner.config.environmentFilePaths) {
      variables.addAll(
        _readSingleEnvironmentFile(filePath),
      );
    }

    return variables;
  }

  Map<String, dynamic> _readSingleEnvironmentFile(String path) {
    if (!exists(path)) return {};

    final fileContent = tryRead(path)?.toParagraph();
    if (fileContent == null || fileContent.isEmpty) return {};

    final YamlMap envYaml = loadYaml(fileContent);
    final envJson = jsonEncode(envYaml);
    return jsonDecode(envJson);
  }
}
