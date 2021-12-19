part of 'run.dart';

class InputFileReader {
  InputFileReader(this.owner);

  final RunCommand owner;

  Map<String, dynamic> collectVariablesFromInputFiles() {
    final argInputFilePaths = owner.argResults![owner.kOptionInputFile] ?? const [];
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
