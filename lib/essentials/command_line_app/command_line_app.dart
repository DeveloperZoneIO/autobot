import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:meta/meta.dart';

part 'cla_controller.dart';
part 'cla_message.dart';
part 'cla_exit_message.dart';
part 'cla_test_controller.dart';
part 'registered_args.dart';

abstract class CommanLineApp {
  final _controller = _CLAControllerImpl();

  void run() {
    runner(_controller);
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
  void runner(CLAController appController);
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
