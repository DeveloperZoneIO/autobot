import 'package:args/command_runner.dart';
import 'package:autobot/autobot.dart';
import 'package:autobot/common/dcli_utils.dart';
import 'package:autobot/common/path_util.dart';
import 'package:autobot/common/string_util.dart';
import 'package:dcli/dcli.dart';

/// Defines the init command of autobot.
/// `autobot init` creates a autobot config yaml in the working directory.
/// `autobot init -g` creates a autobot config yaml in the home directory.
class InitCommand extends Command {
  InitCommand() {
    argParser.addFlag('global', abbr: 'g', defaultsTo: false);
    argParser.addOption('path', abbr: 'p', defaultsTo: null);
  }

  @override
  String get description => 'Adds a config file to the current working directory.';

  @override
  String get name => 'init';

  static final kDefaultConfigFile = '''
  config:
    templateDirectory: templates/
  '''
      .stripMargin();

  @override
  void run() {
    final bool initGlobal = argResults!['global'] == true;
    String? customPath = argResults!['path'];
    String configFilePath = '$pwd/$kConfigFileName.yaml';

    // GLOBAL
    if (initGlobal) {
      configFilePath = '$homeDir/.$kConfigFileName.yaml';
    }

    // HOME DIR
    else if (customPath == null) {
      configFilePath = '$pwd/$kConfigFileName.yaml';
    }

    // CUSTOM PATH
    else {
      if (customPath.endsWith("/")) {
        final chars = customPath.split('');
        chars.removeLast();
        customPath = chars.join('');
      }

      if (customPath.startsWith('/')) {
        configFilePath = '$customPath/$kConfigFileName.yaml';
      } else {
        configFilePath = '$pwd/$customPath/$kConfigFileName.yaml';
      }
    }

    configFilePath.createDirectory();
    configFilePath.write(kDefaultConfigFile);
  }
}
