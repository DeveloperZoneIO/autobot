import 'package:autobot/shared/base_paths/base_paths.dart';
import 'package:dcli/dcli.dart';

class MockPaths extends BasePaths {
  @override
  String get globalDir => '$pwd/globalTestDirectory';

  @override
  String get localDir => '$pwd/localTestDirectory';
}
