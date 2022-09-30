import 'package:args/command_runner.dart';
import 'package:autobot/common/path_util.dart';
import 'package:autobot/components/files.dart';
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
    final shouldCreateConfigAtCustomPath = customPath != null;
    if (shouldCreateConfigAtCustomPath) {
      _createCustomConfigFile(customPath);
      return;
    }

    _createLocalConfigFile();
  }

  void _createLocalConfigFile() {
    final configFilePath = Files.localPaths.configFile;
    configFilePath.createDirectory();
    configFilePath.write(Files.defaultConfig);
  }

  void _createGlobalConfigFile() {
    final configFilePath = Files.globalPaths.configFile;
    configFilePath.createDirectory();
    configFilePath.write(Files.defaultConfig);
  }

  void _createCustomConfigFile(String filePath) {
    final configFilePath = PathBuilder.from(filePath) //
        .resolve()
        .removeTrailingSlash()
        .append(FileNames.configFileName)
        .get();

    configFilePath.createDirectory();
    configFilePath.write(Files.defaultConfig);
  }
}
