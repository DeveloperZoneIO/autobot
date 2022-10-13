part of 'when.dart';

class Then<T> extends WhenChainHolder<T> {
  Then(super.chain, this._mapper, this._statementHolder);

  final T Function() _mapper;
  final StatementHolder _statementHolder;

  When<T> orWhen(bool statement) {
    _chain.add(WhenChainEntry<T>(_statementHolder._statement, _mapper));
    return When<T>(_chain, () => statement);
  }

  T orElse(T Function() mapper) {
    _chain.add(WhenChainEntry<T>(_statementHolder._statement, mapper));
    return _resolveChain();
  }

  Option<T> orNone() {
    _chain.add(WhenChainEntry<T>(_statementHolder._statement, _mapper));

    try {
      final result = _resolveChain();
      return some(result);
    } on StateError catch (_) {
      return none();
    }
  }

  T _resolveChain() {
    final entry = _chain.entries.firstWhere((it) => it.statement());
    return entry.mapper();
  }
}
