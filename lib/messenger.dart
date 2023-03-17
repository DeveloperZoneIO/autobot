abstract class Messenger {
  void call(MessengerEvent event);
  Never terminateAnd(MessengerEvent event);
}

abstract class MessengerEvent {}

class Print extends MessengerEvent {
  final String message;
  Print(this.message);
}
