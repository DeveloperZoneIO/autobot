import 'package:autobot/pubspec.dart';
import 'package:autobot/tell.dart';
import 'package:dcli/dcli.dart';
import 'package:test/test.dart';
import 'package:autobot/autobot.dart' as autobot;

void main() {
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
