import 'package:autobot/common/dcli_utils.dart';
import 'package:dcli/dcli.dart';

import 'autobot_constants.dart';

class Files {
  static String get localConfigPath => '$pwd/${AutobotConstants.configFileName}';
  static String get globalConfigPath => '$homeDirectory/${AutobotConstants.configFileName}';
}
