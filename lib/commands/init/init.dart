import 'package:args/command_runner.dart';
import 'package:autobot/common/dcli_utils.dart';
import 'package:autobot/common/path_util.dart';
import 'package:autobot/components/autobot_constants.dart';
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

  @override
  void run() {
    final shouldCreateGlobalConfig = argResults!['global'] == true;
    if (shouldCreateGlobalConfig) {
      _createGlobalConfigFile();
      return;
    }

    final customPath = argResults!['path'];
    final shouldCreateCustomConfig = customPath != null;
    if (shouldCreateCustomConfig) {
      _createCustomConfigFile(customPath);
      return;
    }

    _createLocalConfigFile();
  }

  void _createLocalConfigFile() {
    final configFilePath = '$currentWorkingDirectory/${AutobotConstants.configFileName}';
    configFilePath.createDirectory();
    configFilePath.write(AutobotConstants.configFileDefaultContent);
  }

  void _createGlobalConfigFile() {
    final configFilePath = '$homeDirectory/${AutobotConstants.configFileName}';
    configFilePath.createDirectory();
    configFilePath.write(AutobotConstants.configFileDefaultContent);
  }

  void _createCustomConfigFile(String filePath) {
    // remove last "/" if exist
    if (filePath.endsWith("/")) {
      final chars = filePath.split('');
      chars.removeLast();
      filePath = chars.join('');
    }

    final isRelativePath = !filePath.startsWith('/');

    if (isRelativePath) {
      filePath = '$filePath/${AutobotConstants.configFileName}';
    } else {
      filePath = '$pwd/$filePath/${AutobotConstants.configFileName}';
    }

    filePath.createDirectory();
    filePath.write(AutobotConstants.configFileDefaultContent);
  }
}
