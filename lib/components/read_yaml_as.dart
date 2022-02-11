import 'dart:convert';

import 'package:autobot/commands/run/models/template.dart';
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

TaskNode readTask(String filePath) {
  final taskYaml = readYaml(filePath);
  final taskJson = jsonEncode(taskYaml);
  final taskMap = jsonDecode(taskJson);

  final List stepMaps = taskMap['steps'];
  final List<StepNode> steps = stepMaps.map((map) {
    if (map is! Map<String, dynamic>) {
      throw StateError('Unknown step found: $map');
    }

    final stepTypeKey = map.entries.first.key;

    switch (stepTypeKey) {
      case 'ask':
        return Mapper.fromMap<AskStep>(map);
      case 'vars':
        return Mapper.fromMap<VariablesStep>(map);
      case 'read':
        return Mapper.fromMap<ReadStep>(map);
      case 'javascript':
        return Mapper.fromMap<JavascriptStep>(map);
      case 'shell':
        return Mapper.fromMap<ShellScriptStep>(map);
      case 'write':
        return Mapper.fromMap<WriteStep>(map);
      case 'runTask':
        return Mapper.fromMap<RunTaskStep>(map);

      default:
        throw StateError('Unknown step found: $map');
    }
  }).toList();

  return TaskNode(
    meta: Mapper.fromMap(taskMap['meta']),
    steps: steps,
  );
}
