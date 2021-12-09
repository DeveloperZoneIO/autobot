extension NullUtil<T> on T? {
  T orThrow(Exception throwable) {
    if (this == null) throw throwable;
    return this!;
  }
}

extension CastUtil on Object {
  T? as<T>() => (this is T) ? this as T : null;
}
