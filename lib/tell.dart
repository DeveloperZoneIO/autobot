import 'package:dcli/dcli.dart';

void tell(Object? object) {
  TellManager._prints.add(object);
  print(object);
}

class TellManager {
  static final _prints = <Object?>[];

  static Object? get firstPrint => _prints.first;
  static Object? get secondPrint => _prints[1];
  static List<Object?> get allPrints => List.from(_prints);

  static void clearPrints() {
    _prints.clear();
  }
}

class TestManager {
  static void deleteSystemEntry(String path) {
    if (!exists(path)) {
      return;
    }

    isDirectory(path) //
        ? deleteDir(path, recursive: true)
        : delete(path);
  }

  static void deleteAllSystemEntries(List<String> paths) {
    for (var path in paths) {
      deleteSystemEntry(path);
    }
  }
}

class TestFilesManager {
  TestFilesManager(this.systemEntryPaths);
  final List<String> systemEntryPaths;

  void deleteAll() {
    TestManager.deleteAllSystemEntries(systemEntryPaths);
  }
}

extension ArgsExtension on String {
  List<String> toArgs() => this.split(' ');
}
