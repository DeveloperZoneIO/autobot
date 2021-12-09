part of 'run.dart';

class OutputParser {
  OutputParser(this.owner);

  final RunCommand owner;
  final _foundOutputs = <TemplateOutputDefinition>[];

  OutputParser collectOutputsFrom(YamlMap template) {
    final outputList = template['outputs'];
    if (outputList is! YamlList) return this;

    for (final YamlMap outputEntry in outputList) {
      final output = TemplateOutputDefinition(
        path: outputEntry['path'],
        canWrite: outputEntry['write']?.toString() ?? 'true',
        content: outputEntry['content'],
      );
      _foundOutputs.add(output);
    }

    return this;
  }

  List<TemplateOutputDefinition> getOutputs() => List.from(_foundOutputs);
}
