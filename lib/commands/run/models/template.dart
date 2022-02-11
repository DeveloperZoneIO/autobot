import 'package:dart_mappable/dart_mappable.dart';

import 'template.mapper.g.dart';

class TaskNode {
  TaskNode({
    this.meta,
    this.steps = const [],
  });

  final MetaNode? meta;
  final List<StepNode> steps;
}

class MetaNode with Mappable {
  MetaNode(this.title, this.description);

  final String? title;
  final String? description;
}

@MappableClass(discriminatorKey: 'type')
abstract class StepNode with Mappable {}

// @MappableClass(discriminatorValue: MappableClass.useAsDefault)
// class FallbackStep extends StepNode {
//   FallbackStep(String? type, this.key, this.prompt) : super(type);

//   final String? key;
//   final String? prompt;
// }

class AskStep extends StepNode {
  AskStep(this.key, this.prompt);

  final String key;
  final String prompt;
}

class VariablesStep extends StepNode {
  VariablesStep(this.vars);

  final List<Map<String, dynamic>> vars;
}

class ReadStep extends StepNode {
  ReadStep(this.file, this.required);

  final String file;
  final bool required;
}

class JavascriptStep extends StepNode {
  JavascriptStep(this.run_javascript);

  final String run_javascript;
}

class ShellScriptStep extends StepNode {
  ShellScriptStep(this.run_command);

  final String run_command;
}

class WriteStep extends StepNode {
  WriteStep(
    this.path,
    this.content, {
    this.writeMethod = 'default',
    this.enabled = 'yes',
    this.extendAt = 'bottom',
  }) : super();

  final String path;
  final String content;
  final String writeMethod;
  final String enabled;
  final String extendAt;
}

class RunTaskStep extends StepNode {
  RunTaskStep(this.file);

  final String file;
}



// class InputDef with Mappable {
//   InputDef({required this.key, required this.prompt});

//   final String key;
//   final String prompt;
// }

// class OutputDef with Mappable {
//   OutputDef({
//     required this.content,
//     required this.path,
//     this.write = 'yes',
//     this.writeMethod,
//     this.extendAt = 'bottom',
//   });

//   final String content;
//   final String path;
//   final String write;
//   final String? writeMethod;
//   final String extendAt;
// }

// class ScriptDef with Mappable {
//   ScriptDef({
//     this.js,
//     this.shell,
//   });

//   final String? js;
//   final String? shell;
// }
