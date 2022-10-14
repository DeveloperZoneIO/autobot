import 'package:autobot/autobot_cla.dart';
import 'package:autobot/common/types.dart';
import 'package:autobot/components/depenencies.dart';
import 'package:autobot/essentials/command_line_app/command_line_app.dart';
import 'package:autobot/pubspec.dart';
import 'package:autobot/tell.dart';
import 'package:dcli/dcli.dart';
import 'package:test/test.dart';
import 'package:autobot/main.dart' as autobot;

void main() {
  setUp(() {
    Dependencies.initWithMocks(mockRegistrant: (getIt) {
      getIt.registerSingleton<CLAController>(CLATestController());
    });
  });

  tearDown(() {
    Dependencies.reset();
  });

  test('autobot version prints the current version', () {
    AutobotCLA(arguments: 'version'.toArgs()).run();
    final controller = provide<CLAController>().as<CLATestController>();

    expect(
      controller.calledActions.first,
      Print(cyan('autobot ${Pubspec.version}')),
    );
  });
}
