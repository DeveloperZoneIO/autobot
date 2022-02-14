part of 'run.dart';

/// Helper for writting the putput files.
class OutputWriter with TextRenderable {
  /// Converts the given [tasks] into files and writes them.
  OutputWriter writeOutputs(List<OutputTask> tasks) {
    for (var task in tasks) {
      final outputDir = task.outputPath.getDir();
      if (outputDir.isNotEmpty && !exists(outputDir)) {
        createDir(outputDir, recursive: true);
      }

      final writeMethod = task.writeMethod;

      // Keep existing file
      if (writeMethod is KeepExistingFile) {
        if (!exists(task.outputPath)) task.outputPath.write(task.fileContent);
      }

      // Replace existing file
      else if (writeMethod is ReplaceExistingFile) {
        task.outputPath.write(task.fileContent);
      }

      // Replace file
      else if (writeMethod is ExtendFile) {
        if (exists(task.outputPath)) {
          _extendFile(task, writeMethod.extendAt);
        } else {
          task.outputPath.write(task.fileContent);
        }
      }
    }

    return this;
  }

  /// Extends a existing file using the given method defined by [extendAt].
  void _extendFile(OutputTask task, String extendAt) {
    // Bottom
    if (extendAt == 'bottom') {
      task.outputPath.append(task.fileContent);
    }

    // Top
    else if (extendAt == 'top') {
      final existingContent = read(task.outputPath).toParagraph();
      task.outputPath.write(task.fileContent);
      task.outputPath.append(existingContent);
    }

    // Regex
    else {
      final existingContent = read(task.outputPath).toParagraph();
      final matches = extendAt.allMatches(existingContent);
      if (matches.isEmpty) {
        return;
      }

      final newContentChars = task.fileContent.split('');
      final extendedChars = existingContent.split('');
      extendedChars.insertAll(matches.first.end, newContentChars);
      task.outputPath.write(extendedChars.join(''));
    }
  }
}
