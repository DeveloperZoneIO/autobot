extension NullUtil<T> on T? {
  /// Returns the not null value or throws the given [throwable].
  T unpackOrThrow(Exception throwable) {
    if (this == null) throw throwable;
    return this!;
  }

  void unpack(void Function(T) callback) {
    if (this != null) callback(this!);
  }
}

extension CastUtil on Object {
  /// Casts the receiver object to the given type [T] or returns null otherwise.
  T? as<T>() => (this is T) ? this as T : null;
}
