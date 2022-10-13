part of 'when.dart';

extension OptionExtension<T> on Option<T> {
  T get() => (this as Some<T>).value;
}
