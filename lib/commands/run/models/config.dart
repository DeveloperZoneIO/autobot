part of '../run.dart';

class RunConfig {
  RunConfig({
    required this.templateDirectory,
    required this.environmentFilePaths,
  });

  final String templateDirectory;
  final List<String> environmentFilePaths;
}
