import 'dart:convert';

import 'package:autobot/common/yaml_utils.dart';
import 'package:autobot/components/autobot_config.mapper.g.dart';
import 'package:autobot/components/autobot_constants.dart';
import 'package:autobot/components/read_yaml.dart';

class AutobotConfig with Mappable {
  AutobotConfig({required this.taskDir});
  final String taskDir;

  static AutobotConfig? fromFileOrNull(String filePath) {
    try {
      final configYaml = readYaml(filePath);
      final configContentYaml = configYaml.require(
        'config',
        fileName: AutobotConstants.configFileName,
      );

      final configJson = jsonEncode(configContentYaml);
      return Mapper.fromJson(configJson);
    } catch (_) {
      return null;
    }
  }
}
