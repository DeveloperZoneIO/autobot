import 'dart:io';

import 'package:dcli/dcli.dart';

Progress? tryRead(String path) {
  try {
    return read(path);
  } catch (_) {
    return null;
  }
}

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
