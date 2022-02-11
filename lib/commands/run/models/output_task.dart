part of '../run.dart';

abstract class WriteMethod {
  WriteMethod();

  factory WriteMethod.from({required String name, required String extendAt}) {
    switch (name) {
      case ExtendFile.key:
        return ExtendFile(extendAt: extendAt);

      case KeepExistingFile.key:
        return KeepExistingFile();

      case ReplaceExistingFile.key:
        return ReplaceExistingFile();

      default:
        return KeepExistingFile();
    }
  }
}

class ReplaceExistingFile extends WriteMethod {
  static const String key = 'replaceExistingFile';
}

class KeepExistingFile extends WriteMethod {
  static const String key = 'keepExistingFile';
}

class ExtendFile extends WriteMethod {
  static const String key = 'extendFile';

  ExtendFile({required this.extendAt});
  String extendAt;
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
