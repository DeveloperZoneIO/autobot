import 'dart:convert';

import 'package:autobot/commands/run/models/template.mapper.g.dart';
import 'package:autobot/common/exceptions.dart';
import 'package:dcli/dcli.dart';
import 'package:yaml/yaml.dart';

R readYamlAs<R>(String filePath) {
  try {
    final fileContent = read(filePath).toParagraph();
    final fileContentAsYaml = loadYaml(fileContent);
    final fileContentAsJson = jsonEncode(fileContentAsYaml);
    return Mapper.fromJson<R>(fileContentAsJson);
  } on ReadException catch (_) {
    throw TellUser((tell) => tell(red('$filePath doesn not exist')));
  } on YamlException catch (_) {
    throw TellUser((tell) => tell(red('$filePath is no valid yaml file')));
  }
}
