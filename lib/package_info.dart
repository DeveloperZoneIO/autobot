import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:yaml/yaml.dart';

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
    if (value == null) throw MissingPackageField(name: 'name');
    return value;
  }

  static String get description {
    _ensureInitialized();
    final String? value = _pubspec!['description'];
    if (value == null) throw MissingPackageField(name: 'description');
    return value;
  }

  static void _ensureInitialized() {
    if (_pubspec == null) throw MissingPubspec();
  }
}

class PubspecEcxeption implements Exception {}

class MissingPubspec implements PubspecEcxeption {
  @override
  String toString() => 'Autobot is missing a pubspec.yaml file.';
}

class MissingPackageField implements PubspecEcxeption {
  final String name;
  MissingPackageField({
    required this.name,
  });
  @override
  String toString() => 'Autobot pubspec.yaml file is missing the "$name" property.';
}

class MissingPackageVersion implements PubspecEcxeption {
  @override
  String toString() => 'Autobot pubspec.yaml file is missing the "version" property.';
}
