import 'package:args/command_runner.dart';
import 'package:autobot/autobot.dart';
import 'package:autobot/common/dcli_utils.dart';
import 'package:autobot/common/string_util.dart';
import 'package:dcli/dcli.dart';

class InitCommand extends Command {
  InitCommand() {
    argParser.addFlag('global', abbr: 'g', defaultsTo: true);
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
    if (argResults!['global'] == true) {
      '$homeDir/.$kConfigFileName.yaml'.write(kDefaultConfigFile);
    } else {
      '$pwd/$kConfigFileName.yaml'.write(kDefaultConfigFile);
    }
  }
}
