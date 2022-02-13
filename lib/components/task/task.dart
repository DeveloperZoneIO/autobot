import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';
import '../read_yaml.dart';

import 'task.mapper.g.dart';

part 'meta_node.dart';
part 'step_node.dart';
part 'variables_step_node.dart';
part 'ask_step_node.dart';
part 'read_step_node.dart';
part 'javascript_step_node.dart';
part 'run_task_step_node.dart';
part 'command_step_node.dart';
part 'write_step_node.dart';

class Task {
  final MetaNode? meta;
  final List<StepNode> steps;

  Task({this.meta, this.steps = const []});

  factory Task.fromFile(String filePath) => _getTaskFromFile(filePath);
}

Task _getTaskFromFile(String filePath) {
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
        return VariablesStep(map..remove('vars'));
      case 'read':
        return Mapper.fromMap<ReadStep>(map);
      case 'javascript':
        return Mapper.fromMap<JavascriptStep>(map);
      case 'command':
        return Mapper.fromMap<CommandStep>(map);
      case 'write':
        return Mapper.fromMap<WriteStep>(map);
      case 'runTask':
        return Mapper.fromMap<RunTaskStep>(map);

      default:
        throw StateError('Unknown step found: $map');
    }
  }).toList();

  final metaMap = taskMap['meta'];
  MetaNode? meta;

  if (metaMap != null) {
    meta = Mapper.fromMap(metaMap);
  }

  return Task(
    meta: meta,
    steps: steps,
  );
}
