import 'package:autobot/autobot_cla.dart';
import 'package:autobot/components/depenencies.dart';

void main(List<String> args) {
  Dependencies.init();
  final app = AutobotCLA(arguments: args);
  app.run();
}
