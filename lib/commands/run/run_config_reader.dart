part of 'run.dart';

/// Reads the config files from `autobot_config.yaml` that are related to the run command.
class RunConfigReader {
  RunConfigReader(this.owner);

  static const kYamlTemplateDirectoryField = 'templateDirectory';
  static const kYamlEnvironmentFilePathsField = 'environmentFilePaths';

  final RunCommand owner;

  /// Reads and parses the config file.
  RunConfig readConfig() {
    final YamlMap configYaml = ConfigReader.readConfig();

    return RunConfig(
      templateDirectory: _getTemplateDirectory(configYaml),
      environmentFilePaths: _getEnvironmentFiles(configYaml),
    );
  }

  /// Parses the template directory value form the given [configYaml].
  String _getTemplateDirectory(YamlMap configYaml) {
    return configYaml.require(
      kYamlTemplateDirectoryField,
      fileName: kConfigFileName,
    );
  }

  /// Parses the environment file values form the given [configYaml].
  List<String> _getEnvironmentFiles(YamlMap configYaml) {
    final YamlList filePaths =
        configYaml.tryGet(kYamlEnvironmentFilePathsField) ?? YamlList();
    return filePaths.whereType<String>().toList();
  }
}
