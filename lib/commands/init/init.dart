import 'package:args/command_runner.dart';
import 'package:autobot/autobot.dart';
import 'package:autobot/common/dcli_utils.dart';
import 'package:autobot/common/string_util.dart';
import 'package:dcli/dcli.dart';

class InitCommand extends Command {
  InitCommand() {
    argParser.addFlag('global', abbr: 'g', defaultsTo: false);
  }

  @override
  String get description =>
      'Adds a config file to the current working directory.';

  @override
  String get name => 'init';

  static final kDefaultConfigFile = '''
  config:
    templateDirectory: templates/
  '''
      .stripMargin();

  @override
  void run() {
    final initGlobal = argResults!['global'] == true;
    final configFilePath = initGlobal //
        ? '$homeDir/.$kConfigFileName.yaml'
        : '$pwd/$kConfigFileName.yaml';
    configFilePath.write(kDefaultConfigFile);
  }
}
