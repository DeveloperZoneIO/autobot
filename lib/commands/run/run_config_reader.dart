part of 'run.dart';

class RunConfigReader {
  RunConfigReader(this.owner);

  static const kYamlTemplateDirectoryField = 'templateDirectory';
  static const kYamlEnvironmentFilePathsField = 'environmentFilePaths';

  final RunCommand owner;

  RunConfig readConfig() {
    final YamlMap configYaml = ConfigReader.readConfig();

    return RunConfig(
      templateDirectory: _getTemplateDirectory(configYaml),
      environmentFilePaths: _getEnvironmentFiles(configYaml),
    );
  }

  String _getTemplateDirectory(YamlMap configYaml) {
    return configYaml.require(
      kYamlTemplateDirectoryField,
      fileName: kConfigFileName,
    );
  }

  List<String> _getEnvironmentFiles(YamlMap configYaml) {
    final YamlList filePaths = configYaml.require(
      kYamlEnvironmentFilePathsField,
      fileName: kConfigFileName,
    );

    return filePaths.whereType<String>().toList();
  }
}
