import 'package:autobot/autobot.dart';
import 'package:autobot/common/dcli_utils.dart';
import 'package:autobot/common/exceptions.dart';
import 'package:autobot/common/null_utils.dart';
import 'package:dcli/dcli.dart';
import 'package:yaml/yaml.dart';

class ConfigReader {
  /// Reads and parses the autobot configuration yaml.
  ///
  /// It tries to get the local config yaml from the working directory.
  /// It there is none, it reads the global config yaml.
  ///
  /// Throws [MissingConfigFile] if no no autobot config yaml could be found.
  static YamlMap readConfig() {
    final specificFilePath = '$pwd/$kConfigFileName.yaml';
    final globalFilePath = '$homeDir/.$kConfigFileName.yaml';
    final readProgress = tryRead(specificFilePath) ?? tryRead(globalFilePath);
    final templateContent =
        readProgress.unpackOrThrow(MissingConfigFile()).toParagraph();
    return loadYaml(templateContent)['config'];
  }
}
