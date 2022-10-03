import 'commands/run/run.dart';

class ArgumentsResolver {
  List<String> resolveShortcuts(List<String> args, List<String> commandNames) {
    final resolvedArgs = List<String>.from(args);
    if (resolvedArgs.isNotEmpty) {
      final commandFromArgs = resolvedArgs.first;
      final doesCommandExist = commandNames.any((name) => name == commandFromArgs);

      if (!doesCommandExist) {
        final name = RunCommand.kName;
        final taskOption = '--${RunCommandArgs.kOptionTask}';
        resolvedArgs.insertAll(0, [name, taskOption]);
      }
    }

    return resolvedArgs;
  }
}
