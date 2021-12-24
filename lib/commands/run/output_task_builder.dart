part of 'run.dart';

/// Helper for building write tasks.
class OutputTaskBuilder with TextRenderable {
  OutputTaskBuilder(this.owner);

  final RunCommand owner;

  /// Reads all variables so that they can be uses for rendering with mustache.
  OutputTaskBuilder collectVariables(Map<String, dynamic> variables) {
    renderVariables.addAll(variables);
    return this;
  }

  /// Creats the [WirteTask]s with values that already renderd using mustache.
  List<OutputTask> buildTasks(List<OutputDef> outputs) {
    return outputs
        .map((outputDef) {
          if (render(outputDef.write).meansNo) return null;

          return OutputTask(
            fileContent: render(outputDef.content),
            outputPath: render(outputDef.path),
            writeMethod: _getWriteMethod(outputDef),
          );
        })
        .whereType<OutputTask>()
        .toList();
  }

  /// Finds the [WriteMethod] of the given [outputDef].
  WriteMethod _getWriteMethod(OutputDef outputDef) {
    final writeMethod = outputDef.writeMethod;

    switch (writeMethod) {
      case ExtendFile.key:
        return ExtendFile(extendAt: render(outputDef.extendAt));

      case KeepExistingFile.key:
        return KeepExistingFile();

      case ReplaceExistingFile.key:
        return ReplaceExistingFile();

      default:
        return KeepExistingFile();
    }
  }
}
