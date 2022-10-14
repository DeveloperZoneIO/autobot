part of 'command_line_app.dart';

class CLATestController extends CLAController {
  final _calledActions = <CLAControllerAction>[];
  List<CLAControllerAction> get calledActions => List.from(_calledActions);

  @override
  void execute(CLAControllerAction action) {
    _calledActions.add(action);
  }

  @override
  Never terminate(CLAControllerAction action) {
    _calledActions.add(action);
    exit(0);
  }
}
