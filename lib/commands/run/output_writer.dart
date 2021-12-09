part of 'run.dart';

class OutputWriter with TextRenderable {
  OutputWriter(this.owner);

  final RunCommand owner;
  final _writeTasks = <WriteTask>[];

  OutputWriter collectVariables(List<Input> inputs) {
    for (final input in inputs) {
      renderVariables[input.key] = input.value;
    }
    return this;
  }

  OutputWriter createWriteTasks(List<TemplateOutputDefinition> outputs) {
    for (final output in outputs) {
      if (render(output.canWrite).isFalse()) {
        continue;
      }

      _writeTasks.add(WriteTask(
        fileContent: render(output.content),
        outputPath: render(output.path),
      ));
    }

    return this;
  }

  OutputWriter writeOutputs() {
    for (var task in _writeTasks) {
      final outputDir = _getDirectory(task.outputPath);
      if (outputDir.isNotEmpty && !exists(outputDir)) {
        createDir(outputDir, recursive: true);
      }

      task.outputPath.write(task.fileContent);
    }

    return this;
  }

  String _getDirectory(String path) {
    final lastSlashIndex = path.lastIndexOf("/");
    if (lastSlashIndex == path.length) return path;
    return path.replaceRange(lastSlashIndex + 1, null, '');
  }
}
