import 'package:autobot/common/exceptions.dart';
import 'package:autobot/components/autobot_config.dart';
import 'package:dcli/dcli.dart';

import '../common/dcli_utils.dart';
import '../components/autobot_constants.dart';

class AutobotConfigReader {
  AutobotConfig getConfig() {
    final workingPath = '$pwd/${AutobotConstants.configFileName}';
    final homePath = '$homeDirectory/${AutobotConstants.configFileName}';
    final config = AutobotConfig.fromFileOrNull(workingPath) ?? AutobotConfig.fromFileOrNull(homePath);

    if (config == null) {
      throw MissingConfigFile();
    } else {
      return config;
    }
  }
}
