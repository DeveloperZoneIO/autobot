part of 'when.dart';

abstract class WhenChainHolder<T> {
  WhenChainHolder(this._chain);
  final WhenChain<T> _chain;
}
