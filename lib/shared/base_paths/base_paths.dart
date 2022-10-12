import 'dart:io';
import 'package:autobot/common/null_utils.dart';
import 'package:dcli/dcli.dart';

part 'autobot_base_paths.dart';
part 'common_base_paths.dart';

abstract class BasePaths {
  String get localDir;
  String get globalDir;
  String? get customDir => _customDir;

  String inWorkingDir(String path) => localDir + path;
  String inGlobalDir(String path) => localDir + path;
  String? inCustomDir(String path) => customDir?.use((it) => it + path);

  String? _customDir;
  void registerCustomDir(String path) => _customDir;
}
