import 'package:dcli/dcli.dart';

import 'package:autobot/commands/run/run.dart';
import 'package:autobot/components/read_data_file.dart';
import 'package:autobot/components/task/task.dart';

class TaskRunner with TextRenderable {
  final String taskDirectory;

  TaskRunner({required this.taskDirectory});

  Future<void> run(Task task) async {
    for (final step in task.steps) {
      if (step is VariablesStep) handleVariablesStep(step);
      if (step is AskStep) handleAskStep(step.key, step.prompt);
      if (step is JavascriptStep) handleJavascriptStep(step.run);
      if (step is CommandStep) handleCommandStep(step.run);
      if (step is WriteStep) handleWriteStep(step);
      if (step is ReadStep) handleReadStep(step);
      if (step is RunTaskStep) await handleRunTaskStep(step);
    }
  }

  void handleVariablesStep(VariablesStep step) {
    renderData.addAll(step.vars);
  }

  void handleJavascriptStep(String javascript) {
    final vars = JsRunner().run(javascript, renderData);
    renderData.clear();
    renderData.addAll(vars);
  }

  void handleCommandStep(String shellScript) {
    ShellRunner().run(shellScript, renderData);
  }

  void handleAskStep(String key, String prompt) {
    if (!renderData.containsKey(key)) {
      renderData[key] = ask(yellow(render(prompt)));
    }
  }

  void handleWriteStep(WriteStep step) {
    final writeFile = render(step.enabled).meansTrue;
    if (!writeFile) return;

    final outputTask = OutputTask(
      fileContent: render(step.content),
      outputPath: render(step.file),
      writeMethod: WriteMethod.from(
        name: render(step.writeMethod),
        extendAt: render(step.extendAt),
      ),
    );

    OutputWriter().writeOutputs([outputTask]);
  }

  void handleReadStep(ReadStep step) {
    if (step.required) {
      final file = render(step.file);
      final data = readDataFromFiles([file]);
      renderData.addAll(data);
      return;
    }

    final file = render(step.file);
    final data = tryReadDataFromFile([file]);
    if (data != null) {
      renderData.addAll(data);
    }
  }

  Future<void> handleRunTaskStep(RunTaskStep step) async {
    final subtask = Task.fromFile(render(taskDirectory) + render(step.file));
    await run(subtask);
  }
}
