part of 'when.dart';

class WhenChainEntry<T> {
  WhenChainEntry(this.statement, this.mapper);

  final bool Function() statement;
  final T Function() mapper;
}
