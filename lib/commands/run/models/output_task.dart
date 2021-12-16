part of '../run.dart';

abstract class WriteMethod {}

class ReplaceExistingFile extends WriteMethod {
  static const String key = 'replaceExistingFile';
}

class KeepExistingFile extends WriteMethod {
  static const String key = 'keepExistingFile';
}

class ExtendFile extends WriteMethod {
  static const String key = 'extendFile';
}

class OutputTask {
  OutputTask({
    required this.fileContent,
    required this.outputPath,
    required this.writeMethod,
  });

  final String fileContent;
  final String outputPath;
  final WriteMethod writeMethod;
}
