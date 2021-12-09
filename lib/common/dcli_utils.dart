import 'package:dcli/dcli.dart';

Progress? tryRead(String path) {
  try {
    return read(path);
  } catch (_) {
    return null;
  }
}
