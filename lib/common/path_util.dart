import 'package:dcli/dcli.dart';

import '../shared/base_paths/base_paths.dart';

extension StringPathExtension on String {
  String getDir() {
    final lastSlashIndex = lastIndexOf("/");
    if (lastSlashIndex == length) return this;
    return replaceRange(lastSlashIndex + 1, null, '');
  }

  /// Creates all missing directories from path.
  void createDirectory() {
    final directory = getDir();
    if (directory.isNotEmpty && !exists(directory)) {
      createDir(directory, recursive: true);
    }
  }
}

class PathBuilder {
  PathBuilder(this.paths);

  final BasePaths paths;

  PathBuilder from(String path) => this.._path = path;

  String _path = '';

  PathBuilder resolve() {
    final isRelativePath = !_path.startsWith('/');

    if (isRelativePath) {
      _path = '${paths.localDir}/$_path';
    }

    return this;
  }

  PathBuilder removeTrailingSlash() {
    if (_path.endsWith("/")) {
      final chars = _path.split('');
      chars.removeLast();
      _path = chars.join('');
    }

    return this;
  }

  PathBuilder append(String appendix) {
    _path = '$_path/$appendix';

    return this;
  }

  String get() => _path;
}
