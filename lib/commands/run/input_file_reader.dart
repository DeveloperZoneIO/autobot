part of 'run.dart';

/// Reads the input file argument.
class InputFileReader {
  InputFileReader(this.owner);

  final RunCommand owner;

  /// Reads the input files, collects all variables and returns them as a [Map].
  Map<String, dynamic> collectVariablesFromInputFiles() {
    final argInputFilePaths =
        owner.argResults![owner.kOptionInputFile] ?? const [];
    final _inputFileVariables = <String, dynamic>{};

    for (final String inputFilePath in argInputFilePaths) {
      try {
        final fileContent = read(inputFilePath).toParagraph();
        final YamlMap yaml = loadYaml(fileContent);
        final json = jsonEncode(yaml);
        _inputFileVariables.addAll(jsonDecode(json));
      } catch (_) {}
    }

    return Map.from(_inputFileVariables);
  }
}
