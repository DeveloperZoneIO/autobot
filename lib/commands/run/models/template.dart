import 'template.mapper.g.dart';

class TemplateDef with Mappable {
  TemplateDef({
    this.inputs = const [],
    this.scripts = const [],
    this.outputs = const [],
  });

  final List<InputDef> inputs;
  final List<ScriptDef> scripts;
  final List<OutputDef> outputs;
}

class InputDef with Mappable {
  InputDef({required this.key, required this.prompt});

  final String key;
  final String prompt;
}

class OutputDef with Mappable {
  OutputDef({
    required this.content,
    required this.path,
    this.write = 'yes',
    this.writeMethod,
    this.extendAt = 'bottom',
  });

  final String content;
  final String path;
  final String write;
  final String? writeMethod;
  final String extendAt;
}

class ScriptDef with Mappable {
  ScriptDef({this.js});

  final String? js;
}
