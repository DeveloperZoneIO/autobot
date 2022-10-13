part of 'when.dart';

class InitialWhen implements StatementHolder {
  InitialWhen._(this._statement);

  @override
  final bool Function() _statement;

  Then<T> then<T>(T Function() mapper) => Then<T>(WhenChain<T>._(), mapper, this);
}
