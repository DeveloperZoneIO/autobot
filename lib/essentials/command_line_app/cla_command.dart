part of 'command_line_app.dart';

abstract class CLACommand extends Command with RegisteredArgs {
  CLACommand({required this.name, required this.description});

  @override
  final String description;

  @override
  final String name;
}
