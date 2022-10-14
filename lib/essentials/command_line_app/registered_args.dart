part of 'command_line_app.dart';

class OptionsArg extends RegisterableArg {
  final String? defaultsTo;
  final bool mandatory;

  OptionsArg({
    required super.name,
    required super.shortName,
    this.defaultsTo,
    this.mandatory = false,
  });
}

class MultiOptionsArg extends RegisterableArg {
  final List<String>? defaultsTo;

  MultiOptionsArg({
    required super.name,
    required super.shortName,
    this.defaultsTo,
  });
}

class FlagArg extends RegisterableArg {
  final bool? defaultsTo;

  FlagArg({
    required super.name,
    required super.shortName,
    this.defaultsTo,
  });
}

class RegisterableArg {
  RegisterableArg({required this.name, required this.shortName});

  final String name;
  final String shortName;
}

mixin RegisteredArgs on Command {
  ARG register<ARG extends RegisterableArg>(ARG arg) {
    if (arg is FlagArg) {
      argParser.addFlag(
        arg.name,
        abbr: arg.shortName,
        defaultsTo: arg.defaultsTo,
      );
    }

    if (arg is MultiOptionsArg) {
      argParser.addMultiOption(
        arg.name,
        abbr: arg.shortName,
        defaultsTo: arg.defaultsTo,
      );
    }

    if (arg is OptionsArg) {
      argParser.addOption(
        arg.name,
        abbr: arg.shortName,
        defaultsTo: arg.defaultsTo,
        mandatory: arg.mandatory,
      );
    }

    return arg;
  }

  bool has(RegisterableArg arg) {
    if (arg is FlagArg) {
      return argResults?[arg.name] == true;
    }

    return argResults?[arg.name] != null;
  }

  String valueOf(OptionsArg arg) {
    final argValue = argResults![arg.name] as String;

    return _containsFlags(argValue) //
        ? _getActualValue(argValue)
        : argValue;
  }

  List<String> valuesOf(MultiOptionsArg arg) {
    return argResults![arg.name] as List<String>;
  }

  Map<String, String> flagsOf(OptionsArg arg) {
    final argValue = argResults![arg.name] as String;

    return _containsFlags(argValue) //
        ? _getFlags(argValue)
        : {};
  }

  bool _containsFlags(String value) => value.contains(':');

  String _getActualValue(String valueAndFlags) => valueAndFlags.split(':').first;

  Map<String, String> _getFlags(String valueAndFlags) {
    final flags = valueAndFlags.split(':');
    flags.removeAt(0); // removes actual value whit is always the first value

    return flags //
        .asMap()
        .map((index, value) => 'flags$index'.to(value));
  }
}
