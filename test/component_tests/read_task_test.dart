import 'package:autobot/components/components.dart';
import 'package:autobot/components/task/task.dart';
import 'package:dcli/dcli.dart';
import 'package:test/test.dart';

void main() {
  final fullFeatureSetTaskPath = '$pwd/test/tasks/full_feature_set_task.yaml';
  late final Task task;

  final expectedTypeOrder = [
    VariablesStep,
    AskStep,
    AskStep,
    ReadStep,
    JavascriptStep,
    ReadStep,
    CommandStep,
    WriteStep,
    RunTaskStep,
    WriteStep,
  ];

  test('readTask() -> Reads a yaml file and converts it into a task.', () {
    task = Task.fromFile(fullFeatureSetTaskPath);
  });

  test('readTask() -> Can parse meta information', () {
    expect(task.meta?.title, 'BigTask');
    expect(task.meta?.description, 'Serves as a big test task for testing autobot');
  });

  test('readTask() -> Can parse steps', () {
    expect(task.steps.length, expectedTypeOrder.length);
  });

  test('readTask() -> Step order is same as in task file', () {
    final taskStepTypes = task.steps.map((e) => e.runtimeType).toList();
    expect(taskStepTypes, expectedTypeOrder);
  });

  test('readTask() -> Can parse variables step', () {
    final steps = task.steps.whereType<VariablesStep>();
    final vars = steps.first.vars;
    expect(steps.length, 1);
    expect(vars['key'], 'value');
    expect(vars['key2'], 'value');
    expect(vars['sub_map']['sub_map_key_1'], 1);
    expect(vars['sub_map']['sub_map_key_2'], 2);
    expect(vars['list'].length, 2);
    expect(vars['list'][0], 'a');
    expect(vars['list'][1], 'b');
  });

  test('readTask() -> Can parse ask step', () {
    final steps = task.steps.whereType<AskStep>().toList();
    expect(steps.length, 2);
    expect(steps[0].key, 'a');
    expect(steps[0].prompt, 'prompt_a');
    expect(steps[1].key, 'b');
    expect(steps[1].prompt, 'prompt_b');
  });

  test('readTask() -> Can parse read step', () {
    final steps = task.steps.whereType<ReadStep>().toList();
    expect(steps.length, 2);
    expect(steps[0].file, 'some/file/path.yaml');
    expect(steps[0].required, true);
    expect(steps[1].file, 'some/file/path.yaml');
    expect(steps[1].required, false);
  });

  test('readTask() -> Can parse javascript step', () {
    final steps = task.steps.whereType<JavascriptStep>().toList();
    expect(steps.length, 1);
    expect(steps[0].run, 'var x = 123');
  });

  test('readTask() -> Can parse command step', () {
    final steps = task.steps.whereType<CommandStep>().toList();
    expect(steps.length, 1);
    expect(steps[0].run, 'VAR=hallo');
  });

  test('readTask() -> Can parse write step', () {
    final steps = task.steps.whereType<WriteStep>().toList();
    expect(steps.length, 2);
    expect(steps[0].file, 'some/file/path.yaml');
    expect(steps[0].enabled, 'false');
    expect(steps[0].writeMethod, 'extendFile');
    expect(steps[0].extendAt, 'top');
    expect(steps[0].content, 'sdfgjhkfdjvkldjflgadj');
    expect(steps[1].file, 'some/file/path2.yaml');
    expect(steps[1].enabled, 'yes');
    expect(steps[1].writeMethod, 'extendFile');
    expect(steps[1].extendAt, 'top');
    expect(steps[1].content, 'sdfgjhkfdjvkldjflgadj2');
  });

  test('readTask() -> Can parse run task step', () {
    final steps = task.steps.whereType<RunTaskStep>().toList();
    expect(steps.length, 1);
    expect(steps[0].file, 'some/task.yaml');
  });
}
