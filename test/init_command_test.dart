import 'package:autobot/common/dcli_utils.dart';
import 'package:autobot/tell.dart';
import 'package:dcli/dcli.dart';
import 'package:test/test.dart';
import 'package:autobot/main.dart' as autobot;

void main() {
  final _kLocalAutobotDir = '$currentWorkingDirectory/.autobot';
  final _kLocalConfigDir = '$currentWorkingDirectory/.autobot/config.yaml';

  group('init:', () {
    test('Creates local autobot directory and files', () async {
      final filesManager = TestFilesManager([_kLocalConfigDir, _kLocalAutobotDir]);
      filesManager.deleteAll();
      TellManager.clearPrints();

      autobot.main('init'.toArgs());
      expect(exists(_kLocalAutobotDir), true);
      expect(exists(_kLocalConfigDir), true);

      filesManager.deleteAll();
    });

    test('Creates autobot directory and file at custom path', () {
      final customDir = '$currentWorkingDirectory/customDir/';
      final autobotDir = '$customDir.autobot';
      final configFile = '$customDir.autobot/config.yaml';

      final filesManager = TestFilesManager([configFile, autobotDir, customDir]);
      filesManager.deleteAll();
      TellManager.clearPrints();

      autobot.main('init -p customDir/'.toArgs());

      expect(exists(autobotDir), true);
      expect(exists(configFile), true);
      filesManager.deleteAll();
    });

    test('Creates global autobot directory and files', () {
      final autobotDir = '$homeDirectory/.autobot';
      final configFile = '$homeDirectory/.autobot/config.yaml';
      final filesManager = TestFilesManager([configFile, autobotDir]);
      filesManager.deleteAll();
      TellManager.clearPrints();

      autobot.main('init -g'.toArgs());
      expect(exists(autobotDir), true);
      expect(exists(configFile), true);

      filesManager.deleteAll();
    });
  });
}
