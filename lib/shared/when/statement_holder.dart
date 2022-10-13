part of 'when.dart';

abstract class StatementHolder {
  StatementHolder(this._statement);

  final bool Function() _statement;
}
