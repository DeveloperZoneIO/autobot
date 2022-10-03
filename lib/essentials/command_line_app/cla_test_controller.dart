part of 'command_line_app.dart';

class _CLATestController extends CLAController {
  final _calledActions = <CLAControllerAction>[];
  List<String> get calledAction => List.from(_calledActions);

  @override
  void executel(CLAControllerAction action) {
    _calledActions.add(action);
  }
}
