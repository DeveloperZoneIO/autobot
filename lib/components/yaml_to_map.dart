import 'dart:convert';

import 'package:autobot/common/exceptions.dart';
import 'package:dcli/dcli.dart';
import 'package:yaml/yaml.dart';

/// Converts the given [yaml] to a [Map].
Map<String, dynamic> yamlToMap(YamlMap yaml) {
  try {
    final jsonString = jsonEncode(yaml);
    return jsonDecode(jsonString);
  } catch (_) {
    throw TellUser((tell) =>
        tell(red('The YAML file contains features that are not supported by the JSON format.')));
  }
}
