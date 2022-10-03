import 'package:autobot/common/types.dart';
import 'package:dcli/dcli.dart';
import 'package:autobot/common/string_util.dart';
import 'package:autobot/tell.dart';

abstract class PrintableException implements Exception {
  void tellUser();
}

class MissingConfigFile implements PrintableException {
  @override
  String toString() => '''
  No autobot config file found.
  -> Add a "autobot_config.yaml" to the current working directory using "autobot init"

  or

  -> Add a ".autobot_config.yaml" to your home directory using "autobot init -g"
  '''
      .stripMargin();

  @override
  void tellUser() {
    tell(red('No autobot config file found!') + grey('slkjf'));
    tell(grey('Add a autobot_config.yaml to the current working directory using: autobot init'));
    tell(yellow('OR'));
    tell(grey('Add a .autobot_config.yaml to your home directory using: autobot init -g'));
  }
}

class MissingPubspec implements Exception {
  @override
  String toString() => 'Autobot is missing a pubspec.yaml file.';
}

class MissingYamlField implements Exception {
  MissingYamlField({required this.field, required this.file});
  final String field;
  final String file;

  @override
  String toString() => '$file.yaml file is missing the "$field" property.';
}

class MissingNodeInstallation implements PrintableException {
  @override
  String toString() =>
      'node is not installed! Please install node. This is require for running custom javascript.';

  @override
  void tellUser() => tell(red(toString()));
}

class TellUser implements PrintableException {
  TellUser(this.teller);

  final void Function(void Function(Object?)) teller;

  @override
  String toString() => 'TellUser exception';

  @override
  void tellUser() => teller(tell);
}
