import 'dart:convert';
import 'dart:io';

import 'package:autobot/components/autobot_config.mapper.g.dart';
import 'package:autobot/components/config_file_valiator.dart';
import 'package:autobot/components/read_yaml.dart';

class AutobotConfig with Mappable {
  AutobotConfig({required this.taskDir});
  final String taskDir;

  static AutobotConfig? fromPath(String filePath) {
    try {
      final configYaml = readYaml(filePath);
      final issues = ConfigFileValiator.checkConfigFileContent(configYaml);

      if (issues.isNotEmpty) {
        throw issues.last;
      }

      final configJson = jsonEncode(configYaml['config']);
      return Mapper.fromJson(configJson);
    } catch (_) {
      return null;
    }
  }

  static AutobotConfig? fromFile(File file) => fromPath(file.path);
}
