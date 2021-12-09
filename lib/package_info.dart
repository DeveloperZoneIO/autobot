import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:yaml/yaml.dart';

import 'common/exceptions.dart';

class PackageInfo {
  static YamlMap? _pubspec;
  static const kPubspecFileName = 'pubspec.yaml';

  static Future<void> load() async {
    var directory = Directory.current;
    if (!directory.isAbsolute) directory = directory.absolute;
    if (!await directory.exists()) throw MissingPubspec();
    final pubspecContent = read('${directory.path}/$kPubspecFileName').toParagraph();
    _pubspec = loadYaml(pubspecContent);
  }

  static String get name {
    _ensureInitialized();
    final String? value = _pubspec!['name'];
    if (value == null) throw MissingYamlField(field: 'name', file: 'pubspec');
    return value;
  }

  static String get description {
    _ensureInitialized();
    final String? value = _pubspec!['description'];
    if (value == null) throw MissingYamlField(field: 'description', file: 'pubspec');
    return value;
  }

  static void _ensureInitialized() {
    if (_pubspec == null) throw MissingPubspec();
  }
}
