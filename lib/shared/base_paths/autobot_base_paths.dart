part of 'base_paths.dart';

class AutobotBasePaths extends BasePaths {
  @override
  String get globalDir => _homeDir;

  @override
  String get localDir => _workingDir;
}
