import 'package:autobot/messenger.dart';
import 'package:autobot/di/get_it_provider.dart';
import 'package:autobot/tell.dart';
import 'package:dcli/dcli.dart';
import 'package:test/test.dart';
import 'package:autobot/main.dart' as autobot;

import 'mocks/test_messenger.dart';

final _configFilePath = '$pwd/.autobot_config.yaml';
final _configFileContent = '''
config:
  taskDir: test/tasks/''';

void main() {
  final messenger = TestMessenger();

  setUp(() async {
    TellManager.clearPrints();

    if (exists(_configFilePath)) delete(_configFilePath);
    _configFilePath.write(_configFileContent);
    await provider.clear();
    provider.registerSingleton<Messenger>(messenger);
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

  test('autobot run -> keepExistingFile writeMethods work like expected.',
      () async {
    final filePath = '$pwd/letters.txt';
    if (exists(filePath)) delete(filePath);

    autobot.main(["run", "-t", "keep_existing_file_task"]);

    await Future.delayed(const Duration(milliseconds: 100));

    expect(exists(filePath), true);
    expect(read(filePath).toParagraph(), "abc");
    delete(filePath);
  });

  test('autobot run -> replaceExistingFile writeMethods work like expected.',
      () {
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
    final filePath2 = '$pwd/sh_result_2.txt';

    if (exists(filePath1)) delete(filePath1);
    if (exists(filePath2)) delete(filePath2);

    autobot.main(["run", "-t", "shell_task", "-i", "shellVar=sh_result_2.txt"]);

    expect(exists(filePath1), true);
    expect(exists(filePath2), true);

    delete(filePath1);
    delete(filePath2);
  });

  test('autobot run -> Can read yaml files.', () {
    autobot.main(["run", "-t", "read_task"]);

    final resultFilePath = '$pwd/result.txt';
    expect(exists(resultFilePath), true);

    expect(read(resultFilePath).toParagraph(), "abc123! + 123456789");
    delete(resultFilePath);
  });

  test('autobot run -> Can run subtasks.', () async {
    autobot.main(["run", "-t", "with_subtask_task"]);

    final resultFilePath = '$pwd/subtask_test_result.txt';
    await Future.delayed(const Duration(milliseconds: 50));
    expect(exists(resultFilePath), true);

    expect(read(resultFilePath).toParagraph(), "a, b, c, d");
    delete(resultFilePath);
  });

  test('autobot run -> run --task shortcut is working', () async {
    final filePath = '$pwd/letters.txt';
    if (exists(filePath)) delete(filePath);

    autobot.main(["replace_existing_file_task"]);

    expect(exists(filePath), true);
    expect(read(filePath).toParagraph(), "def");
    delete(filePath);
  });

  test('autobot run -> can parse task flags', () async {
    final filePath = '$pwd/result.txt';
    if (exists(filePath)) delete(filePath);

    autobot.main(["flag_test_task:FLAG_A:FLAG_B"]);

    expect(exists(filePath), true);
    expect(read(filePath).toParagraph(),
        "First flag is FLAG_A and second flag is FLAG_B");
    delete(filePath);
  });
}
