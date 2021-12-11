import 'package:args/command_runner.dart';
import 'package:autobot/autobot.dart';
import 'package:autobot/common/exceptions.dart';
import 'package:autobot/common/null_utils.dart';
import 'package:autobot/config_reader.dart';
import 'package:dcli/dcli.dart';
import 'package:mustache_template/mustache.dart';
import 'package:yaml/yaml.dart';

part 'input_reader.dart';
part 'output_reader.dart';
part 'output_writer.dart';
part 'utils/render_mixin.dart';
part 'utils/string_to_bool.dart';
part 'template_reader.dart';

part 'models/config.dart';
part 'models/input.dart';
part 'models/template_input_definition.dart';
part 'models/template_output_definition.dart';
part 'models/write_task.dart';

class RunCommand extends Command {
  static const kOptionTemplate = 'template';
  static const kOptionTemplateAbbr = 't';

  RunCommand() {
    _addOptions();
  }

  late final RunConfig config;

  @override
  String get description => 'Runs a yaml template file.';
  @override
  String get name => 'run';

  @override
  void run() {
    config = _readConfig();
    final template = readTemplate();
    final inputs = readInputs(template);
    final outputs = readOutputs(template);
    writeOutputs(outputs, inputs: inputs);
  }

  RunConfig _readConfig() {
    final YamlMap configYaml = ConfigReader.readConfig();
    final String? templateDirectory = configYaml['templateDirectory'];

    return RunConfig(
      templateDirectory: templateDirectory.unpackOrThrow(MissingYamlField(
        field: 'templateDirectory',
        file: kConfigFileName,
      )),
    );
  }

  void _addOptions() {
    argParser.addOption(kOptionTemplate, abbr: kOptionTemplateAbbr, mandatory: true);
  }
}

extension FunctionalRunCommand on RunCommand {
  YamlMap readTemplate() => RunTemplateReader(this).readTemplate();

  List<Input> readInputs(YamlMap template) => InputReader(this) //
      .collectInputDefinitionsFrom(template)
      .askForInputvalues()
      .getUserInputs();

  List<TemplateOutputDefinition> readOutputs(YamlMap template) => OutputReader(this) //
      .collectOutputsFrom(template)
      .getOutputs();

  void writeOutputs(List<TemplateOutputDefinition> outputs, {required List<Input> inputs}) => OutputWriter(this) //
      .collectVariables(inputs)
      .createWriteTasks(outputs)
      .writeOutputs();
}
