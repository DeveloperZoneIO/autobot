import 'package:autobot/autobot_cla.dart';
import 'package:autobot/components/depenencies.dart';
import 'package:autobot/shared/paths/paths.dart';
import 'package:autobot/tell.dart';
import 'package:dcli/dcli.dart';
import 'package:test/test.dart';

import 'mocks/mock_paths.dart';

void main() {
  late TestFilesManager fileManager;

  setUp(() {
    // Register mock dependencies
    getIt.registerSingleton<Paths>(MockPaths());

    fileManager = TestFilesManager();
    fileManager.trackAll([
      getIt<Paths>().workingDir,
      getIt<Paths>().globalDir,
    ]);

    TellManager.clearPrints();
  });

  tearDown(() {
    // Remove all registered dependencies
    getIt.reset();
    // Delete all files create by test
    fileManager.deleteAll();
  });

  group('init:', () {
    test('Creates local autobot directory and files', () {
      final autobotDir = '${getIt<Paths>().workingDir}/.autobot';
      final configFile = '${getIt<Paths>().workingDir}/.autobot/config.yaml';
      fileManager.trackAll([configFile, autobotDir]);

      AutobotCLA(arguments: 'init'.toArgs()).run();
      expect(exists(autobotDir), true);
      expect(exists(configFile), true);
    });

    test('Creates autobot directory and file at custom path', () {
      final customDir = '${getIt<Paths>().workingDir}/customDir/';
      final autobotDir = '$customDir.autobot';
      final configFile = '$customDir.autobot/config.yaml';

      fileManager.trackAll([configFile, autobotDir, customDir]);

      AutobotCLA(arguments: 'init -p customDir/'.toArgs()).run();
      expect(exists(autobotDir), true);
      expect(exists(configFile), true);
    });

    test('Creates global autobot directory and files', () {
      final autobotDir = '${getIt<Paths>().globalDir}/.autobot';
      final configFile = '${getIt<Paths>().globalDir}/.autobot/config.yaml';
      fileManager.trackAll([configFile, autobotDir]);

      AutobotCLA(arguments: 'init -g'.toArgs()).run();
      expect(exists(autobotDir), true);
      expect(exists(configFile), true);
    });
  });
}
