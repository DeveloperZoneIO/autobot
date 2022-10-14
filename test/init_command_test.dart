import 'package:autobot/autobot_cla.dart';
import 'package:autobot/commands/init/init.dart';
import 'package:autobot/components/depenencies.dart';
import 'package:autobot/essentials/command_line_app/command_line_app.dart';
import 'package:autobot/shared/base_paths/base_paths.dart';
import 'package:autobot/tell.dart';
import 'package:dcli/dcli.dart';
import 'package:test/test.dart';

import 'mocks/mock_paths.dart';

void main() {
  late TestFilesManager fileManager;

  setUp(() {
    Dependencies.initWithMocks(mockRegistrant: (getIt) {
      getIt.registerSingleton<BasePaths>(MockPaths());
      getIt.registerSingleton<CLAController>(CLATestController());
    });

    fileManager = TestFilesManager();
    fileManager.trackAll([
      provide<BasePaths>().localDir,
      provide<BasePaths>().globalDir,
    ]);

    TellManager.clearPrints();
  });

  tearDown(() {
    Dependencies.reset();
    fileManager.deleteAll();
  });

  group('init:', () {
    test('Creates local autobot directory and files', () {
      final autobotDir = '${getIt<BasePaths>().localDir}/.autobot';
      final configFile = '${getIt<BasePaths>().localDir}/.autobot/config.yaml';
      fileManager.trackAll([configFile, autobotDir]);

      AutobotCLA(arguments: 'init'.toArgs()).run();
      expect(exists(autobotDir), true);
      expect(exists(configFile), true);
    });

    test('Creates autobot directory and file at custom path', () {
      final customDir = '${getIt<BasePaths>().localDir}/customDir/';
      final autobotDir = '$customDir.autobot';
      final configFile = '$customDir.autobot/config.yaml';

      fileManager.trackAll([configFile, autobotDir, customDir]);

      AutobotCLA(arguments: 'init -p customDir/'.toArgs()).run();
      expect(exists(autobotDir), true);
      expect(exists(configFile), true);
    });

    test('Creates global autobot directory and files', () {
      final autobotDir = '${getIt<BasePaths>().globalDir}/.autobot';
      final configFile = '${getIt<BasePaths>().globalDir}/.autobot/config.yaml';
      fileManager.trackAll([configFile, autobotDir]);

      AutobotCLA(arguments: 'init -g'.toArgs()).run();
      expect(exists(autobotDir), true);
      expect(exists(configFile), true);
    });
  });
}
