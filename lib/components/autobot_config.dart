import 'dart:convert';

import 'package:autobot/components/autobot_config.mapper.g.dart';
import 'package:autobot/components/read_yaml.dart';

class AutobotConfig with Mappable {
  AutobotConfig({required this.taskDir});
  final String taskDir;

  static AutobotConfig? fromFileOrNull(String filePath) {
    try {
      final configYaml = readYaml(filePath)['config'];
      final configJson = jsonEncode(configYaml);
      return Mapper.fromJson(configJson);
    } catch (_) {
      return null;
    }
  }
}
