part of 'run.dart';

/// Reads all kind of environment data.
class EnvironmentReader {
  EnvironmentReader(this.owner);

  final RunCommand owner;

  /// Reads the environment variables of current shell.
  Map<String, String> readEnvironment() => Platform.environment;

  /// Reads the custom environment files defined by the user. (`autobot_config.environmentFilePaths`)
  Map<String, dynamic> readEnvironmentFiles() {
    final variables = <String, dynamic>{};

    for (final filePath in owner.config.environmentFilePaths) {
      variables.addAll(
        _readSingleEnvironmentFile(filePath),
      );
    }

    return variables;
  }

  /// Reads a single environment file.
  Map<String, dynamic> _readSingleEnvironmentFile(String path) {
    if (!exists(path)) return {};

    final fileContent = tryRead(path)?.toParagraph();
    if (fileContent == null || fileContent.isEmpty) return {};

    final YamlMap envYaml = loadYaml(fileContent);
    final envJson = jsonEncode(envYaml);
    return jsonDecode(envJson);
  }
}
