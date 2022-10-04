import 'dart:io';
import 'package:autobot/common/null_utils.dart';
import 'package:dcli/dcli.dart';

part 'autobot_paths.dart';
part 'common_paths.dart';

abstract class Paths {
  String get workingDir;
  String get globalDir;
  String? get customDir => _customDir;

  String inWorkingDir(String path) => workingDir + path;
  String inGlobalDir(String path) => workingDir + path;
  String? inCustomDir(String path) => customDir?.use((it) => it + path);

  String? _customDir;
  void registerCustomDir(String path) => _customDir;
}
