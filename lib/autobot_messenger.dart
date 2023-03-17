import 'dart:io';
import 'messenger.dart';

class AutobotMessenger extends Messenger {
  @override
  void call(MessengerEvent event) {
    if (event is Print) {
      print(event.message);
    }
  }

  @override
  Never terminateAnd(MessengerEvent event) {
    call(event);
    exit(0);
  }
}
