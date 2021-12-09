part of 'run.dart';

typedef Key = String;
typedef Value = String;
typedef Prompt = String;

class RunInputParser {
  RunInputParser(this.owner);

  final RunCommand owner;
  final _evaluatedInputs = <RunInput>[];

  /// Map<Key, Prompt>
  final _inputDefinitionsFromYaml = <Key, Prompt>{};

  RunInputParser collectInputDefinitionsFrom(YamlMap template) {
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

  RunInputParser askForInputvalues() {
    for (final inputDefinition in _inputDefinitionsFromYaml.entries) {
      final key = inputDefinition.key;
      final prompt = inputDefinition.value;
      final value = ask(yellow(prompt));

      _evaluatedInputs.add(RunInput(
        key: key,
        value: value,
      ));
    }

    return this;
  }

  List<RunInput> getUserInputs() => List.from(_evaluatedInputs);
}
