part of 'run.dart';

class RunTemplateReader {
  RunTemplateReader(this.owner);

  final RunCommand owner;
  String get _templateFileName => owner.argResults![RunCommand.kOptionTemplate];

  YamlMap readTemplate() {
    final filePath = '${owner.config.templateDirectory}$_templateFileName.yaml';
    final templateContent = read(filePath).toParagraph();
    return loadYaml(templateContent);
  }
}
