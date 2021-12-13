part of 'run.dart';

class RunConfigReader {
  RunConfigReader(this.owner);

  final RunCommand owner;

  RunConfig readConfig() {
    final YamlMap configYaml = ConfigReader.readConfig();
    final String? templateDirectory = configYaml['templateDirectory'];

    return RunConfig(
      templateDirectory: templateDirectory.unpackOrThrow(MissingYamlField(
        field: 'templateDirectory',
        file: kConfigFileName,
      )),
    );
  }
}
