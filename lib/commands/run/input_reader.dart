part of 'run.dart';

typedef Key = String;
typedef Value = String;

/// Reads the input argument.
class InputReader {
  InputReader(this.owner);

  final RunCommand owner;
  final _argumentInputs = <Key, Value>{};

  /// Reads the input argument and collects all variables.
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

  /// Asks the cli user for the missing inputs value and returns them as a [Map].
  Map<Key, Value> askForInputvalues(TemplateDef template) {
    return template.inputs.toMap((inputDef) {
      return Pair(
        key: inputDef.key,
        value: _argumentInputs.tryGet(inputDef.key) ?? ask(yellow(inputDef.prompt)),
      );
    });
  }
}
