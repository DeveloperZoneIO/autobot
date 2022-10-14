import 'package:autobot/common/types.dart';

extension MapUtil<K, V> on Map<K, V> {
  /// Returns the value of [key] or null if the [key] doesn't exist.
  V? tryGet(K key) => containsKey(key) ? this[key] : null;
}

extension ListUtil<T> on List<T> {
  /// Converts the list to [Map].
  /// Use [collector] to convert each element to a key-value [Pair], which represents a map entry.
  Map<K, V> toMap<K, V>(Pair<K, V>? Function(T element) collector) {
    final resultMap = <K, V>{};

    for (final element in this) {
      final pair = collector(element);
      if (pair != null) {
        resultMap[pair.key] = pair.value;
      }
    }

    return resultMap;
  }
}

extension ListNullUtil<T> on List<T?> {
  /// Filters list for not null elements.
  List<T> whereNotNull() {
    final result = where((element) => element != null).toList();
    return result as List<T>;
  }
}

/// Merges many maps.
Map<K, V> mergeAll<K, V>(List<Map<K, V>> maps) {
  final resultMap = <K, V>{};
  for (final map in maps) {
    resultMap.addAll(map);
  }

  return resultMap;
}

/// Merges two maps.
Map<K, V> merge<K, V>(Map<K, V> first, Map<K, V> second) {
  return mergeAll([first, second]);
}

extension MapEntryBuilder<T> on T {
  MapEntry<T, R> to<R>(R value) => MapEntry(this, value);
}
