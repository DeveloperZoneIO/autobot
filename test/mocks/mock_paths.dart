import 'package:autobot/shared/paths/paths.dart';
import 'package:dcli/dcli.dart';

class MockPaths extends Paths {
  @override
  String get globalDir => '$pwd/globalTestDirectory';

  @override
  String get workingDir => '$pwd/localTestDirectory';
}
