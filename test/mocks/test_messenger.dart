import 'dart:io';

import 'package:autobot/messenger.dart';

class TerminateEvent extends MessengerEvent {
  final MessengerEvent event;
  TerminateEvent(this.event);
}

class TestMessenger extends Messenger {
  final _events = <MessengerEvent>[];
  List<MessengerEvent> get events => List.from(_events);

  @override
  void call(MessengerEvent event) {
    _events.add(event);
  }

  @override
  Never terminateAnd(MessengerEvent event) {
    _events.add(TerminateEvent(event));
    exit(0);
  }
}
