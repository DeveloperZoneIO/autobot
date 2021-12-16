part of 'run.dart';

class OutputTaskBuilder with TextRenderable {
  OutputTaskBuilder(this.owner);

  final RunCommand owner;

  OutputTaskBuilder collectInputs(List<Input> inputs) {
    for (final input in inputs) {
      renderVariables[input.key] = input.value;
    }
    return this;
  }

  List<OutputTask> buildTasks(List<OutputDef> outputs) {
    return outputs
        .map((outputDef) {
          if (render(outputDef.write).meansNo) return null;

          return OutputTask(
            fileContent: render(outputDef.content),
            outputPath: render(outputDef.path),
            writeMethod: _getWriteMethod(outputDef.writeMethod),
          );
        })
        .whereType<OutputTask>()
        .toList();
  }

  WriteMethod _getWriteMethod(String? writeMethodKey) {
    switch (writeMethodKey) {
      case ExtendFile.key:
        return ExtendFile();

      case KeepExistingFile.key:
        return KeepExistingFile();

      case ReplaceExistingFile.key:
        return ReplaceExistingFile();

      default:
        return KeepExistingFile();
    }
  }
}
