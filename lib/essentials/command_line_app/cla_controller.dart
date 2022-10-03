part of 'command_line_app.dart';

abstract class CLAController {
  void executel(CLAControllerAction action);
}

abstract class CLAControllerAction {}

class Print extends CLAControllerAction {
  late final List<String> messages;

  Print(
    String msg1, [
    String? msg2,
    String? msg3,
    String? msg4,
    String? msg5,
    String? msg6,
    String? msg7,
    String? msg8,
    String? msg9,
  ]) {
    messages = [msg1, msg2, msg3, msg4, msg5, msg6, msg7, msg8, msg9].whereType<String>().toList();
  }
}

class ExitApp extends Print {
  ExitApp(
    super.msg1, [
    super.msg2,
    super.msg3,
    super.msg4,
    super.msg5,
    super.msg6,
    super.msg7,
    super.msg8,
    super.msg9,
  ]);
}
