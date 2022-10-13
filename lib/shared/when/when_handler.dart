part of 'when.dart';

class When<T> extends WhenChainHolder<T> implements StatementHolder {
  When(super.chain, this._statement);

  @override
  final bool Function() _statement;

  Then<T> then(T Function() mapper) => Then<T>(_chain, mapper, this);
}
