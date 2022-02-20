import 'package:autobot/common/exceptions.dart';
import 'package:dcli/dcli.dart';
import 'package:yaml/yaml.dart';

/// Reads the yaml file from [filePath] and returns the content as [YamlMap].
YamlMap readYaml(String filePath) {
  try {
    final fileContent = read(filePath).toParagraph();
    return loadYaml(fileContent);
  } on ReadException catch (_) {
    throw TellUser((tell) => tell(red('$filePath doesn not exist')));
  } on YamlException catch (_) {
    throw TellUser((tell) => tell(red('$filePath is no valid yaml file')));
  }
}
