extension MapUtil<K, V> on Map<K, V> {
  /// Returns the value of [key] or null if the [key] doesn't exist.
  V? tryGet(K key) => containsKey(key) ? this[key] : null;
}

extension ListUtil<T> on List<T> {
  /// Converts the receiver map into a [Map].
  /// Use [keyProvider] to provide the key for a given list element.
  /// Use [valueProvider] to provide the value for a given list element.
  Map<K, V> toMap<K, V>({
    required K Function(T) keyProvider,
    required V Function(T) valueProvider,
  }) {
    final map = <K, V>{};
    for (final element in this) {
      map[keyProvider(element)] = valueProvider(element);
    }

    return map;
  }
}
