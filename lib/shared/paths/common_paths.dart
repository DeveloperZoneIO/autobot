part of 'paths.dart';

String get _homeDir {
  try {
    if (Platform.isMacOS) return Platform.environment['HOME']!;
    if (Platform.isLinux) return Platform.environment['HOME']!;
    if (Platform.isWindows) return Platform.environment['UserProfile']!;
    throw Exception();
  } catch (_) {
    throw Exception('Missing home directory');
  }
}

String get _workingDir => pwd;
