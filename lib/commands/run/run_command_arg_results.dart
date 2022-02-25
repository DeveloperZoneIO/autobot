part of 'run.dart';

class RunCommandArgs {
  final ArgParser _parser;
  final ArgResults Function() _resultsProvier;

  RunCommandArgs(this._parser, this._resultsProvier);

  static final kOptionTask = 'task';
  static final kOptionTaskAbbr = 't';
  static final kOptionInput = 'input';
  static final kOptionInputAbbr = 'i';
  static final kOptionInputFile = 'input-file';
  static final kOptionInputFileAbbr = 'f';

  List<String> get inputVariables => _resultsProvier()[kOptionInput] ?? const [];
  List<String> get dataFilePaths => _resultsProvier()[kOptionInputFile] ?? const [];
  String get taskName => _parseTaskName(_resultsProvier()[kOptionTask]) + '.yaml';
  Map<String, String> get taskFlags => _parseTaskFlags(_resultsProvier()[kOptionTask]);

  void initOptions() {
    _parser.addOption(kOptionTask, abbr: kOptionTaskAbbr, mandatory: true);
    _parser.addMultiOption(kOptionInput, abbr: kOptionInputAbbr);
    _parser.addMultiOption(kOptionInputFile, abbr: kOptionInputFileAbbr);
  }

  String _parseTaskName(String taskArgValue) {
    return taskArgValue.split(':').first;
  }

  Map<String, String> _parseTaskFlags(String taskArgValue) {
    final values = taskArgValue.split(':');
    values.removeAt(0);

    final map = <String, String>{};
    var index = 1;
    for (final flagValue in values) {
      map['flag${index++}'] = flagValue;
    }

    return map;
  }
}
