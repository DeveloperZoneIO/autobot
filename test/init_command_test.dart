import 'package:autobot/common/dcli_utils.dart';
import 'package:autobot/tell.dart';
import 'package:dcli/dcli.dart';
import 'package:test/test.dart';
import 'package:autobot/autobot.dart' as autobot;
import 'package:yaml/yaml.dart';

void main() {
  final _kDefaultConfigFilePath = '$pwd/.autobot_config.yaml';
  test('`autobot init` creates config in working directory', () async {
    TellManager.clearPrints();
    TestManager.deleteIfExists(_kDefaultConfigFilePath);

    // Run init command
    autobot.main(['init']);

    expect(exists(_kDefaultConfigFilePath), true);
    final YamlMap config = loadYaml(read(_kDefaultConfigFilePath).toParagraph());
    expect(config['config'] is YamlMap, true);
    expect(config['config']['taskDir'] is String, true);
  });

  test('`autobot init -p` creates config in given path', () {
    final configFilePath = '$pwd/customDir/subDir/.autobot_config.yaml';
    TellManager.clearPrints();
    TestManager.deleteIfExists(configFilePath);

    // Run init command
    autobot.main(['init', '-p', 'customDir/subDir/']);

    expect(exists(configFilePath), true);
    final YamlMap config = loadYaml(read(configFilePath).toParagraph());
    expect(config['config'] is YamlMap, true);
    expect(config['config']['taskDir'] is String, true);
    TestManager.deleteIfExists(configFilePath);
  });

  test('`autobot init -g` creates config in home directory', () {
    final configFilePath = '$homeDirectory/.autobot_config.yaml';
    TellManager.clearPrints();
    TestManager.deleteIfExists(configFilePath);

    // Run init command
    autobot.main(['init', '-g']);

    expect(exists(configFilePath), true);
    final YamlMap config = loadYaml(read(configFilePath).toParagraph());
    expect(config['config'] is YamlMap, true);
    expect(config['config']['taskDir'] is String, true);
  });
}
