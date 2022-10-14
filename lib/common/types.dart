import 'package:equatable/equatable.dart';

typedef VoidCallback = void Function();

class Pair<K, V> extends Equatable {
  Pair({required this.key, required this.value});

  final K key;
  final V value;

  @override
  List<Object?> get props => [key, value];
}

extension Caster<T> on T {
  R as<R>() => this as R;
}
