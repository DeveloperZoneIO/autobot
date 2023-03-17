import 'dart:async';

typedef ProviderFactory<T> = T Function();

typedef Disposer<T> = FutureOr Function(T param);

abstract class Provider {
  T get<T extends Object>();

  void registerFactory<T extends Object>(
    ProviderFactory<T> factory, {
    String? instanceName,
  });

  void registerSingleton<T extends Object>(
    T instance, {
    String? instanceName,
    Disposer<T>? dispose,
  });

  void tryRegisterSingleton<T extends Object>(
    T instance, {
    String? instanceName,
    Disposer<T>? dispose,
  });

  void registerLazySingleton<T extends Object>(
    ProviderFactory<T> factory, {
    String? instanceName,
    Disposer<T>? dispose,
  });

  Future<void> clear();
}
