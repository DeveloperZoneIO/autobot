import 'package:get_it/get_it.dart';

import 'provider.dart';

final Provider provider = GetItProvider();
T provide<T extends Object>() => provider.get<T>();

class GetItProvider extends Provider {
  GetIt get _getIt => GetIt.instance;

  @override
  T get<T extends Object>() => GetIt.instance<T>();

  @override
  void registerFactory<T extends Object>(
    ProviderFactory<T> factory, {
    String? instanceName,
  }) {
    return _getIt.registerFactory(
      factory,
      instanceName: instanceName,
    );
  }

  @override
  void registerSingleton<T extends Object>(
    T instance, {
    String? instanceName,
    Disposer<T>? dispose,
  }) {
    return _getIt.registerSingleton(
      instance,
      instanceName: instanceName,
      dispose: dispose,
    );
  }

  @override
  void registerLazySingleton<T extends Object>(
    ProviderFactory<T> factory, {
    String? instanceName,
    Disposer<T>? dispose,
  }) {
    return _getIt.registerLazySingleton(
      factory,
      instanceName: instanceName,
      dispose: dispose,
    );
  }

  @override
  Future<void> clear() {
    return _getIt.reset();
  }
}
