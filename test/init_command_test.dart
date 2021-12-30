import 'package:autobot/common/dcli_utils.dart';
import 'package:autobot/tell.dart';
import 'package:dcli/dcli.dart';
import 'package:test/test.dart';
import 'package:autobot/autobot.dart' as autobot;
import 'package:yaml/yaml.dart';

void main() {
  final configFilePath = '$pwd/autobot_config.yaml';

  test('`autobot init` creates config in working directory', () {
    TellManager.clearPrints();
    TestManager.deleteIfExists(configFilePath);

    // Run init command
    autobot.main(['init']);

    expect(exists(configFilePath), true);
    final YamlMap config = loadYaml(read(configFilePath).toParagraph());
    expect(config['config'] is YamlMap, true);
    expect(config['config']['templateDirectory'] is String, true);
  });

  test('`autobot init -g` creates config in home directory', () {
    final configFilePath = '$homeDir/.autobot_config.yaml';
    TellManager.clearPrints();
    TestManager.deleteIfExists(configFilePath);

    // Run init command
    autobot.main(['init', '-g']);

    expect(exists(configFilePath), true);
    final YamlMap config = loadYaml(read(configFilePath).toParagraph());
    expect(config['config'] is YamlMap, true);
    expect(config['config']['templateDirectory'] is String, true);
  });
}
