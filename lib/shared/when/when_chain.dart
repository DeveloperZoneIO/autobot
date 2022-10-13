part of 'when.dart';

class WhenChain<T> {
  WhenChain._();

  final _chain = <WhenChainEntry<T>>[];

  void add(WhenChainEntry<T> entry) => _chain.add(entry);

  List<WhenChainEntry<T>> get entries => List.from(_chain);
}
