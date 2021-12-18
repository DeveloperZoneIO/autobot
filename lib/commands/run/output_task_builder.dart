part of 'run.dart';

class OutputTaskBuilder with TextRenderable {
  OutputTaskBuilder(this.owner);

  final RunCommand owner;

  OutputTaskBuilder collectVariables(Map<String, dynamic> variables) {
    renderVariables.addAll(variables);
    return this;
  }

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
