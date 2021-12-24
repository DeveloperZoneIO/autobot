import 'package:autobot/autobot.dart';
import 'package:autobot/pubspec.dart';
import 'package:autobot/tell.dart' as tell;
import 'package:dcli/dcli.dart';
import 'package:test/test.dart';
import 'package:autobot/autobot.dart' as autobot;

void main() {
  test('autobot version prints the current version', () {
    tell.prints.clear();
    final arguments = ['version'];
    autobot.main(arguments);
    expect(tell.prints, [orange('autobot ${Pubspec.version}')]);
  });
}
