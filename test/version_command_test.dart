import 'package:autobot/di/get_it_provider.dart';
import 'package:autobot/pubspec.dart';
import 'package:autobot/tell.dart';
import 'package:dcli/dcli.dart';
import 'package:test/test.dart';
import 'package:autobot/main.dart' as autobot;

void main() {
  setUp(() async {
    await provider.clear();
  });

  test('autobot version prints the current version', () {
    TellManager.clearPrints();
    final arguments = ['version'];
    autobot.main(arguments);

    expect(
      TellManager.firstPrint,
      orange('autobot ${Pubspec.version}'),
    );
  });
}
