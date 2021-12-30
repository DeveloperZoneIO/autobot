import 'dart:convert';

import 'package:autobot/commands/run/models/template.mapper.g.dart';
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

/// Reads a yaml file from [filePath] and returns the content as a object of type [R].
R readYamlAs<R>(String filePath) {
  final fileContentAsJson = jsonEncode(readYaml(filePath));
  return Mapper.fromJson<R>(fileContentAsJson);
}
