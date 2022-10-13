import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:meta/meta.dart';

part 'cla_controller.dart';
part 'cla_message.dart';
part 'cla_exit_message.dart';
part 'cla_test_controller.dart';
part 'registered_args.dart';

abstract class CommanLineApp {
  CommanLineApp(name, String description) : _commandRunner = CommandRunner(name, description) {
    onCreate(_commandRegistrator);
    _commandRegistrator._commands.forEach(_commandRunner.addCommand);
  }

  final CommandRunner _commandRunner;
  final appController = _CLAControllerImpl();
  final _commandRegistrator = CommandRegistrator._();

  void run() {
    final args = getArguments(_commandRunner.commands.values.toList());
    _commandRunner.run(args);
    // runZonedGuarded(
    //   () => runner(_controller),
    //   _onError,
    // );
  }

  void _onError(Object error, StackTrace trace) {
    if (error is CLAMessage) {
      _printMessage(error);
    } else if (error is CLAExitMessage) {
      _printMessage(error);
      _exitTool();
    } else {
      throw error;
    }
  }

  void _printMessage(CLAMessage message) {
    message.messages.forEach(print);
  }

  void _exitTool() {
    exit(0);
  }

  @protected
  void onCreate(CommandRegistrator register);

  @protected
  List<String> getArguments(List<Command> commands);
}

class CommandRegistrator {
  CommandRegistrator._();

  final _commands = <Command>[];

  void call(Command command) {
    _commands.add(command);
  }
}

class _CLAControllerImpl extends CLAController {
  final _calledActions = <CLAControllerAction>[];
  List<String> get calledAction => List.from(_calledActions);

  @override
  void execute(CLAControllerAction action) {
    if (action is Print) {
      action.messages.forEach(print);
    }
  }

  @override
  Never terminate(CLAControllerAction action) {
    execute(action);
    exit(0);
  }
}
