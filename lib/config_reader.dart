import 'package:autobot/autobot.dart';
import 'package:autobot/common/dcli_utils.dart';
import 'package:autobot/common/exceptions.dart';
import 'package:autobot/common/null_utils.dart';
import 'package:dcli/dcli.dart';
import 'package:yaml/yaml.dart';

class ConfigReader {
  static YamlMap readConfig() {
    final specificFilePath = '$pwd/$kConfigFileName.yaml';
    final globalFilePath = '$homeDir/.$kConfigFileName.yaml';
    final readProgress = tryRead(specificFilePath) ?? tryRead(globalFilePath);
    final templateContent = readProgress.unpackOrThrow(MissingConfigFile()).toParagraph();
    return loadYaml(templateContent)['config'];
  }
}
