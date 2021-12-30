import 'package:autobot/components/read_yaml_as.dart';
import 'package:autobot/components/yaml_to_map.dart';
import 'package:dcli/dcli.dart';
import 'package:test/test.dart';

void main() {
  test('yamlToMap() -> converts a YamlMap to a native dart Map<String, dynamic>', () {
    final bigTaskPath = '$pwd/test/tasks/big_task.yaml';
    final yaml = readYaml(bigTaskPath);
    final map = yamlToMap(yaml);

    expect(map['inputs'], isA<List>());
    expect(map['inputs'][0]['key'], 'a');
    expect(map['inputs'][0]['prompt'], 'prompt_a');
    expect(map['inputs'][1]['key'], 'b');
    expect(map['inputs'][1]['prompt'], 'prompt_b');
    expect(map['inputs'][2]['key'], 'c');
    expect(map['inputs'][2]['prompt'], 'prompt_c');

    expect(map['scripts'], isA<List>());
    expect(map['scripts'][0]['js'].trimRight(), 'autobot.inputs.var1 = "a"');
    expect(map['scripts'][1]['js'].trimRight(), 'autobot.inputs.var2 = "b"');

    expect(map['outputs'], isA<List>());
    expect(map['outputs'][0]['path'], 'result.txt');
    expect(map['outputs'][0]['write'], true);
    expect(map['outputs'][0]['writeMethod'], 'extendFile');
    expect(map['outputs'][0]['extendAt'], 'top');
    expect(map['outputs'][0]['content'].trimRight(),
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.');
    expect(map['outputs'][1]['path'], 'result2.txt');
    expect(map['outputs'][1]['write'], true);
    expect(map['outputs'][1]['writeMethod'], 'extendFile');
    expect(map['outputs'][1]['extendAt'], 'top');
    expect(map['outputs'][1]['content'].trimRight(),
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.');
  });
}
