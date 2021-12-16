part of 'run.dart';

class OutputWriter with TextRenderable {
  OutputWriter(this.owner);

  final RunCommand owner;

  OutputWriter writeOutputs(List<OutputTask> tasks) {
    for (var task in tasks) {
      final outputDir = _getDirectory(task.outputPath);
      if (outputDir.isNotEmpty && !exists(outputDir)) {
        createDir(outputDir, recursive: true);
      }

      // Keep existing file
      if (task.writeMethod is KeepExistingFile) {
        if (!exists(task.outputPath)) task.outputPath.write(task.fileContent);
      }

      // Replace existing file
      else if (task.writeMethod is ReplaceExistingFile) {
        task.outputPath.write(task.fileContent);
      }

      // Replace file
      else if (task.writeMethod is ExtendFile) {
        if (exists(task.outputPath)) {
          task.outputPath.append(task.fileContent);
        } else {
          task.outputPath.write(task.fileContent);
        }
      }
    }

    return this;
  }

  String _getDirectory(String path) {
    final lastSlashIndex = path.lastIndexOf("/");
    if (lastSlashIndex == path.length) return path;
    return path.replaceRange(lastSlashIndex + 1, null, '');
  }
}
