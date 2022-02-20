import 'package:autobot/common/dcli_utils.dart';
import 'package:dcli/dcli.dart';

class Resources {
  static const configFileName = 'autobot_config.yaml';
  static String get pathLocalConfigFile => pwd + configFileName;
  static String get pathGlobalConfigFile => homeDirectory + configFileName;
}
