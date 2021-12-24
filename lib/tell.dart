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
  static void deleteIfExists(String filePath) {
    if (exists(filePath)) {
      delete(filePath);
    }
  }
}
