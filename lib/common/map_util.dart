extension MapUtil<K, V> on Map<K, V> {
  V? tryGet(K key) => containsKey(key) ? this[key] : null;
}
