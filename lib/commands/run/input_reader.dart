part of 'run.dart';

typedef Key = String;
typedef Value = String;
typedef Prompt = String;

class InputReader {
  InputReader(this.owner);

  final RunCommand owner;

  List<Input> askForInputvalues(TemplateDef template) {
    return template.inputs.map((inputDef) {
      return Input(
        key: inputDef.key,
        value: ask(yellow(inputDef.prompt)),
      );
    }).toList();
  }
}
