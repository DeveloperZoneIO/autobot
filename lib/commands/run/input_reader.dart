part of 'run.dart';

typedef Key = String;
typedef Value = String;

class InputReader {
  InputReader(this.owner);

  final RunCommand owner;
  final _argumentInputs = <Key, Value>{};

  InputReader collectInputsFromArgs() {
    final argInputs = owner.argResults![owner.kOptionInput] ?? const [];

    for (final String keyValuePair in argInputs) {
      try {
        final pair = keyValuePair.split('=');
        final key = pair[0].trim();
        final value = pair[1].trim();
        _argumentInputs[key] = value;
      } catch (_) {}
    }

    return this;
  }

  Map<Key, Value> askForInputvalues(TemplateDef template) {
    return template.inputs.toMap(
      keyProvider: (inputDef) => inputDef.key,
      valueProvider: (inputDef) {
        final argumentInput = _argumentInputs.tryGet(inputDef.key);
        return argumentInput ?? ask(yellow(inputDef.prompt));
      },
    );
  }
}
