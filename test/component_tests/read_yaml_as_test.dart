import 'package:autobot/commands/run/models/template.dart';
import 'package:autobot/components/read_yaml_as.dart';
import 'package:autobot/tell.dart';
import 'package:dcli/dcli.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    TellManager.clearPrints();
  });

  test('readYamlAs() -> Reads yaml file and returns a object representation', () {
    final bigTaskPath = '$pwd/test/test_tasks/big_task.yaml';
    final template = readYamlAs<TemplateDef>(bigTaskPath);

    // Check inputs
    expect(template.inputs.length, 3);
    expect(template.inputs[0].key, 'a');
    expect(template.inputs[0].prompt, 'prompt_a');
    expect(template.inputs[1].key, 'b');
    expect(template.inputs[1].prompt, 'prompt_b');
    expect(template.inputs[2].key, 'c');
    expect(template.inputs[2].prompt, 'prompt_c');

    // Check scrpts
    expect(template.scripts.length, 2);
    expect(template.scripts[0].js?.trimRight(), 'autobot.inputs.var1 = "a"');
    expect(template.scripts[1].js?.trimRight(), 'autobot.inputs.var2 = "b"');

    // Check outputs
    expect(template.outputs.length, 2);
    expect(template.outputs[0].path, 'result.txt');
    expect(template.outputs[0].write, 'true');
    expect(template.outputs[0].writeMethod, 'extendFile');
    expect(template.outputs[0].extendAt, 'top');
    expect(
      template.outputs[0].content.trimRight(),
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',
    );

    expect(template.outputs[1].path, 'result2.txt');
    expect(template.outputs[1].write, 'true');
    expect(template.outputs[1].writeMethod, 'extendFile');
    expect(template.outputs[1].extendAt, 'top');
    expect(
      template.outputs[1].content.trimRight(),
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',
    );
  });
}
