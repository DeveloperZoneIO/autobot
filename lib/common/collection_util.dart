extension MapUtil<K, V> on Map<K, V> {
  V? tryGet(K key) => containsKey(key) ? this[key] : null;
}

extension ListUtil<T> on List<T> {
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
