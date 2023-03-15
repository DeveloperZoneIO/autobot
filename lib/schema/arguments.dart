import 'dart:collection';

class Arguments extends ListBase<String> {
  final List<String> _values;

  Arguments(this._values);

  factory Arguments.from(List<String> args) => Arguments(List.from(args));

  @override
  int get length => _values.length;

  @override
  operator [](int index) => _values[index];

  @override
  void operator []=(int index, value) => _values[index] = value;

  @override
  set length(int newLength) {
    _values.length = newLength;
  }
}
