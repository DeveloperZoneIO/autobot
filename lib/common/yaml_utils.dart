import 'package:autobot/common/exceptions.dart';
import 'package:yaml/yaml.dart';

extension YamlUtil on YamlMap {
  dynamic require(String key, {required String fileName}) {
    final value = this[key];

    if (value == null) {
      throw MissingYamlField(field: key, file: fileName);
    }

    return value;
  }
}
