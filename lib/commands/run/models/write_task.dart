part of '../run.dart';

class WriteTask {
  WriteTask({
    required this.fileContent,
    required this.outputPath,
  });

  final String fileContent;
  final String outputPath;
}
