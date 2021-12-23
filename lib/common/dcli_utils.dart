import 'dart:io';

import 'package:dcli/dcli.dart';

/// Reads the file content from the given [path].
/// Returns null if the file couldn't be found or the parsing failed.
Progress? tryRead(String path) {
  try {
    return read(path);
  } catch (_) {
    return null;
  }
}

/// Returns the home directory of the OS.
String get homeDir {
  try {
    if (Platform.isMacOS) return Platform.environment['HOME']!;
    if (Platform.isLinux) return Platform.environment['HOME']!;
    if (Platform.isWindows) return Platform.environment['UserProfile']!;
    throw Exception();
  } catch (_) {
    throw Exception('Missing home directory');
  }
}
