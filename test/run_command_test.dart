import 'package:autobot/tell.dart';
import 'package:dcli/dcli.dart';
import 'package:test/test.dart';
import 'package:autobot/autobot.dart' as autobot;

final _configFilePath = '$pwd/autobot_config.yaml';
final _configFileContent = '''
config:
  templateDirectory: test/tasks/
  environmentFilePaths:
    - test/variable_files/secrets.yaml''';

void main() {
  setUp(() {
    TellManager.clearPrints();

    if (exists(_configFilePath)) delete(_configFilePath);
    _configFilePath.write(_configFileContent);
  });

  test('autobot run -> full feature set is working.', () {
    autobot.main([
      "run",
      "-t",
      "quote_and_class_task",
      "-i",
      "answer=it is always been done this way,caption=Grace Hopper,configClass=BuildConfig",
      "-f",
      "test/variable_files/dev_build_config.yaml"
    ]);

    final quoteFilePath = '$pwd/quote.txt';
    expect(exists(quoteFilePath), true);
    expect(
      read(quoteFilePath).toParagraph(),
      "“The most damaging phrase in the language is.. it is always been done this way” - Grace Hopper",
    );
    delete(quoteFilePath);

    final buildConfigFilePath = '$pwd/build_config.dart';
    expect(exists(buildConfigFilePath), true);
    expect(
      read(buildConfigFilePath).toParagraph().trimRight(),
      '''
class BuildConfig {
  static const String baseUrl = 'http://www.google.com/api/v4/';
  static const String apiKey = 'askfjqlksajf09ajioq34href893qhfeoaid;q3489fahicoies';
  static const double version = 38;
  static const bool isDebug = true;
  static const bool isProduction = false;
}''',
    );

    delete(buildConfigFilePath);

    expect(exists('$pwd/hidden1.txt'), false);
    expect(exists('$pwd/hidden2.txt'), false);
    expect(exists('$pwd/hidden3.txt'), false);
  });

  test('autobot run -> keepExistingFile writeMethods work like expected.', () async {
    final filePath = '$pwd/letters.txt';
    if (exists(filePath)) delete(filePath);

    autobot.main(["run", "-t", "keep_existing_file_task"]);

    await Future.delayed(const Duration(milliseconds: 100));

    expect(exists(filePath), true);
    expect(read(filePath).toParagraph(), "abc");
    delete(filePath);
  });

  test('autobot run -> replaceExistingFile writeMethods work like expected.', () {
    final filePath = '$pwd/letters.txt';
    if (exists(filePath)) delete(filePath);

    autobot.main(["run", "-t", "replace_existing_file_task"]);

    expect(exists(filePath), true);
    expect(read(filePath).toParagraph(), "def");
    delete(filePath);
  });

  test('autobot run -> extendFile writeMethods work like expected.', () {
    final filePath = '$pwd/letters.txt';
    if (exists(filePath)) delete(filePath);

    autobot.main(["run", "-t", "extend_file_task"]);

    expect(exists(filePath), true);
    expect(read(filePath).toParagraph(), "LETTERS ---\nabc\ndef\nghi");
    delete(filePath);
  });

  test('autobot run -> shell.', () {
    final filePath1 = '$pwd/sh_result.txt';
    final filePath2 = '$pwd/shellVarValue';

    if (exists(filePath1)) delete(filePath1);
    if (exists(filePath2)) delete(filePath2);

    autobot.main(["run", "-t", "shell_task", "-i", "shellVar=shellVarValue"]);

    expect(exists(filePath1), true);
    expect(exists(filePath2), true);

    delete(filePath1);
    delete(filePath2);
  });
}
