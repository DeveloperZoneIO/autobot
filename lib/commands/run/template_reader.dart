part of 'run.dart';

class RunTemplateReader {
  RunTemplateReader(this.owner);

  final RunCommand owner;
  String get _templateFileName => owner.argResults![RunCommand.kOptionTemplate];

  TemplateDef readTemplate() {
    final filePath = '${owner.config.templateDirectory}$_templateFileName.yaml';
    final templateContent = read(filePath).toParagraph();
    final templateYaml = loadYaml(templateContent);
    final templateJson = jsonEncode(templateYaml);
    return Mapper.fromJson(templateJson);
  }
}
