part of 'command_line_app.dart';

class OptionsArgument extends RegisterableArg<String> {
  OptionsArgument({
    required super.name,
    required super.shortName,
    super.defaultsTo,
  });
}

class FlagArgument extends RegisterableArg<bool> {
  FlagArgument({
    required super.name,
    required super.shortName,
    super.defaultsTo,
  });
}

class RegisterableArg<VALUE> {
  RegisterableArg({
    required this.name,
    required this.shortName,
    this.defaultsTo,
  });

  final String name;
  final String shortName;
  final VALUE? defaultsTo;
}

mixin RegisteredArgs on Command {
  ARG register<ARG extends RegisterableArg>(ARG arg) {
    if (arg is FlagArgument) {
      argParser.addFlag(arg.name, abbr: arg.shortName, defaultsTo: arg.defaultsTo);
    }

    if (arg is OptionsArgument) {
      argParser.addOption(arg.name, abbr: arg.shortName, defaultsTo: arg.defaultsTo);
    }

    return arg;
  }

  bool has(RegisterableArg arg) {
    if (arg is FlagArgument) {
      return argResults?[arg.name] == true;
    }

    return argResults?[arg.name] != null;
  }

  String valueOf(OptionsArgument arg) => argResults![arg.name];
}
