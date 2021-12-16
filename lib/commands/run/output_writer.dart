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

  String _getDirectory(String path) {
    final lastSlashIndex = path.lastIndexOf("/");
    if (lastSlashIndex == path.length) return path;
    return path.replaceRange(lastSlashIndex + 1, null, '');
  }
}
