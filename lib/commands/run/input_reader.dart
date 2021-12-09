part of 'run.dart';

typedef Key = String;
typedef Value = String;
typedef Prompt = String;

class InputReader {
  InputReader(this.owner);

  final RunCommand owner;
  final _evaluatedInputs = <Input>[];

  /// Map<Key, Prompt>
  final _inputDefinitionsFromYaml = <Key, Prompt>{};

  InputReader collectInputDefinitionsFrom(YamlMap template) {
    final inputList = template['inputs'];
    if (inputList is! YamlList) {
      return this;
    }

    for (final YamlMap inputEntry in inputList) {
      final key = inputEntry['key'];
      final prompt = inputEntry['prompt'];
      _inputDefinitionsFromYaml[key] = prompt;
    }

    return this;
  }

  InputReader askForInputvalues() {
    for (final inputDefinition in _inputDefinitionsFromYaml.entries) {
      final key = inputDefinition.key;
      final prompt = inputDefinition.value;
      final value = ask(yellow(prompt));

      _evaluatedInputs.add(Input(
        key: key,
        value: value,
      ));
    }

    return this;
  }

  List<Input> getUserInputs() => List.from(_evaluatedInputs);
}
