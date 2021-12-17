import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';

import 'template.dart';


// === ALL STATICALLY REGISTERED MAPPERS ===

var _mappers = <String, BaseMapper>{
  // primitive mappers
  _typeOf<dynamic>():  PrimitiveMapper((dynamic v) => v),
  _typeOf<String>():   PrimitiveMapper<String>((dynamic v) => v.toString()),
  _typeOf<int>():      PrimitiveMapper<int>((dynamic v) => num.parse(v.toString()).round()),
  _typeOf<double>():   PrimitiveMapper<double>((dynamic v) => double.parse(v.toString())),
  _typeOf<num>():      PrimitiveMapper<num>((dynamic v) => num.parse(v.toString())),
  _typeOf<bool>():     PrimitiveMapper<bool>((dynamic v) => v is num ? v != 0 : v.toString() == 'true'),
  _typeOf<DateTime>(): DateTimeMapper(),
  _typeOf<List>():     IterableMapper<List>(<T>(Iterable<T> i) => i.toList(), <T>(f) => f<List<T>>()),
  _typeOf<Set>():      IterableMapper<Set>(<T>(Iterable<T> i) => i.toSet(), <T>(f) => f<Set<T>>()),
  _typeOf<Map>():      MapMapper<Map>(<K, V>(Map<K, V> map) => map, <K, V>(f) => f<Map<K, V>>()),
  // class mappers
  _typeOf<TemplateDef>(): TemplateDefMapper._(),
  _typeOf<InputDef>(): InputDefMapper._(),
  _typeOf<OutputDef>(): OutputDefMapper._(),
  _typeOf<ScriptDef>(): ScriptDefMapper._(),
  // enum mappers
  // custom mappers
};


// === GENERATED CLASS MAPPERS AND EXTENSIONS ===

class TemplateDefMapper extends BaseMapper<TemplateDef> {
  TemplateDefMapper._();

  @override Function get decoder => decode;
  TemplateDef decode(dynamic v) => _checked(v, (Map<String, dynamic> map) => fromMap(map));
  TemplateDef fromMap(Map<String, dynamic> map) => TemplateDef(inputs: map.getListOpt('inputs') ?? const [], scripts: map.getListOpt('scripts') ?? const [], outputs: map.getListOpt('outputs') ?? const []);

  @override Function get encoder => (TemplateDef v) => encode(v);
  dynamic encode(TemplateDef v) => toMap(v);
  Map<String, dynamic> toMap(TemplateDef t) => {'inputs': Mapper.toValue(t.inputs), 'scripts': Mapper.toValue(t.scripts), 'outputs': Mapper.toValue(t.outputs)};

  @override String? stringify(TemplateDef self) => 'TemplateDef(inputs: ${Mapper.asString(self.inputs)}, scripts: ${Mapper.asString(self.scripts)}, outputs: ${Mapper.asString(self.outputs)})';
  @override int? hash(TemplateDef self) => Mapper.hash(self.inputs) ^ Mapper.hash(self.scripts) ^ Mapper.hash(self.outputs);
  @override bool? equals(TemplateDef self, TemplateDef other) => Mapper.isEqual(self.inputs, other.inputs) && Mapper.isEqual(self.scripts, other.scripts) && Mapper.isEqual(self.outputs, other.outputs);

  @override Function get typeFactory => (f) => f<TemplateDef>();
}

extension TemplateDefMapperExtension on TemplateDef {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  TemplateDefCopyWith<TemplateDef> get copyWith => TemplateDefCopyWith(this, _$identity);
}

abstract class TemplateDefCopyWith<$R> {
  factory TemplateDefCopyWith(TemplateDef value, Then<TemplateDef, $R> then) = _TemplateDefCopyWithImpl<$R>;
  ListCopyWith<$R, InputDef, InputDefCopyWith<$R>> get inputs;
  ListCopyWith<$R, ScriptDef, ScriptDefCopyWith<$R>> get scripts;
  ListCopyWith<$R, OutputDef, OutputDefCopyWith<$R>> get outputs;
  $R call({List<InputDef>? inputs, List<ScriptDef>? scripts, List<OutputDef>? outputs});
}

class _TemplateDefCopyWithImpl<$R> extends BaseCopyWith<TemplateDef, $R> implements TemplateDefCopyWith<$R> {
  _TemplateDefCopyWithImpl(TemplateDef value, Then<TemplateDef, $R> then) : super(value, then);

  @override ListCopyWith<$R, InputDef, InputDefCopyWith<$R>> get inputs => ListCopyWith(_value.inputs, (v, t) => InputDefCopyWith(v, t), (v) => call(inputs: v));
  @override ListCopyWith<$R, ScriptDef, ScriptDefCopyWith<$R>> get scripts => ListCopyWith(_value.scripts, (v, t) => ScriptDefCopyWith(v, t), (v) => call(scripts: v));
  @override ListCopyWith<$R, OutputDef, OutputDefCopyWith<$R>> get outputs => ListCopyWith(_value.outputs, (v, t) => OutputDefCopyWith(v, t), (v) => call(outputs: v));
  @override $R call({List<InputDef>? inputs, List<ScriptDef>? scripts, List<OutputDef>? outputs}) => _then(TemplateDef(inputs: inputs ?? _value.inputs, scripts: scripts ?? _value.scripts, outputs: outputs ?? _value.outputs));
}

class InputDefMapper extends BaseMapper<InputDef> {
  InputDefMapper._();

  @override Function get decoder => decode;
  InputDef decode(dynamic v) => _checked(v, (Map<String, dynamic> map) => fromMap(map));
  InputDef fromMap(Map<String, dynamic> map) => InputDef(key: map.get('key'), prompt: map.get('prompt'));

  @override Function get encoder => (InputDef v) => encode(v);
  dynamic encode(InputDef v) => toMap(v);
  Map<String, dynamic> toMap(InputDef i) => {'key': Mapper.toValue(i.key), 'prompt': Mapper.toValue(i.prompt)};

  @override String? stringify(InputDef self) => 'InputDef(key: ${Mapper.asString(self.key)}, prompt: ${Mapper.asString(self.prompt)})';
  @override int? hash(InputDef self) => Mapper.hash(self.key) ^ Mapper.hash(self.prompt);
  @override bool? equals(InputDef self, InputDef other) => Mapper.isEqual(self.key, other.key) && Mapper.isEqual(self.prompt, other.prompt);

  @override Function get typeFactory => (f) => f<InputDef>();
}

extension InputDefMapperExtension on InputDef {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  InputDefCopyWith<InputDef> get copyWith => InputDefCopyWith(this, _$identity);
}

abstract class InputDefCopyWith<$R> {
  factory InputDefCopyWith(InputDef value, Then<InputDef, $R> then) = _InputDefCopyWithImpl<$R>;
  $R call({String? key, String? prompt});
}

class _InputDefCopyWithImpl<$R> extends BaseCopyWith<InputDef, $R> implements InputDefCopyWith<$R> {
  _InputDefCopyWithImpl(InputDef value, Then<InputDef, $R> then) : super(value, then);

  @override $R call({String? key, String? prompt}) => _then(InputDef(key: key ?? _value.key, prompt: prompt ?? _value.prompt));
}

class OutputDefMapper extends BaseMapper<OutputDef> {
  OutputDefMapper._();

  @override Function get decoder => decode;
  OutputDef decode(dynamic v) => _checked(v, (Map<String, dynamic> map) => fromMap(map));
  OutputDef fromMap(Map<String, dynamic> map) => OutputDef(content: map.get('content'), path: map.get('path'), write: map.getOpt('write') ?? 'yes', writeMethod: map.getOpt('writeMethod'), extendAt: map.getOpt('extendAt') ?? 'bottom');

  @override Function get encoder => (OutputDef v) => encode(v);
  dynamic encode(OutputDef v) => toMap(v);
  Map<String, dynamic> toMap(OutputDef o) => {'content': Mapper.toValue(o.content), 'path': Mapper.toValue(o.path), 'write': Mapper.toValue(o.write), if (Mapper.toValue(o.writeMethod) != null) 'writeMethod': Mapper.toValue(o.writeMethod), 'extendAt': Mapper.toValue(o.extendAt)};

  @override String? stringify(OutputDef self) => 'OutputDef(content: ${Mapper.asString(self.content)}, path: ${Mapper.asString(self.path)}, write: ${Mapper.asString(self.write)}, writeMethod: ${Mapper.asString(self.writeMethod)}, extendAt: ${Mapper.asString(self.extendAt)})';
  @override int? hash(OutputDef self) => Mapper.hash(self.content) ^ Mapper.hash(self.path) ^ Mapper.hash(self.write) ^ Mapper.hash(self.writeMethod) ^ Mapper.hash(self.extendAt);
  @override bool? equals(OutputDef self, OutputDef other) => Mapper.isEqual(self.content, other.content) && Mapper.isEqual(self.path, other.path) && Mapper.isEqual(self.write, other.write) && Mapper.isEqual(self.writeMethod, other.writeMethod) && Mapper.isEqual(self.extendAt, other.extendAt);

  @override Function get typeFactory => (f) => f<OutputDef>();
}

extension OutputDefMapperExtension on OutputDef {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  OutputDefCopyWith<OutputDef> get copyWith => OutputDefCopyWith(this, _$identity);
}

abstract class OutputDefCopyWith<$R> {
  factory OutputDefCopyWith(OutputDef value, Then<OutputDef, $R> then) = _OutputDefCopyWithImpl<$R>;
  $R call({String? content, String? path, String? write, String? writeMethod, String? extendAt});
}

class _OutputDefCopyWithImpl<$R> extends BaseCopyWith<OutputDef, $R> implements OutputDefCopyWith<$R> {
  _OutputDefCopyWithImpl(OutputDef value, Then<OutputDef, $R> then) : super(value, then);

  @override $R call({String? content, String? path, String? write, Object? writeMethod = _none, String? extendAt}) => _then(OutputDef(content: content ?? _value.content, path: path ?? _value.path, write: write ?? _value.write, writeMethod: or(writeMethod, _value.writeMethod), extendAt: extendAt ?? _value.extendAt));
}

class ScriptDefMapper extends BaseMapper<ScriptDef> {
  ScriptDefMapper._();

  @override Function get decoder => decode;
  ScriptDef decode(dynamic v) => _checked(v, (Map<String, dynamic> map) => fromMap(map));
  ScriptDef fromMap(Map<String, dynamic> map) => ScriptDef(js: map.getOpt('js'));

  @override Function get encoder => (ScriptDef v) => encode(v);
  dynamic encode(ScriptDef v) => toMap(v);
  Map<String, dynamic> toMap(ScriptDef s) => {if (Mapper.toValue(s.js) != null) 'js': Mapper.toValue(s.js)};

  @override String? stringify(ScriptDef self) => 'ScriptDef(js: ${Mapper.asString(self.js)})';
  @override int? hash(ScriptDef self) => Mapper.hash(self.js);
  @override bool? equals(ScriptDef self, ScriptDef other) => Mapper.isEqual(self.js, other.js);

  @override Function get typeFactory => (f) => f<ScriptDef>();
}

extension ScriptDefMapperExtension on ScriptDef {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  ScriptDefCopyWith<ScriptDef> get copyWith => ScriptDefCopyWith(this, _$identity);
}

abstract class ScriptDefCopyWith<$R> {
  factory ScriptDefCopyWith(ScriptDef value, Then<ScriptDef, $R> then) = _ScriptDefCopyWithImpl<$R>;
  $R call({String? js});
}

class _ScriptDefCopyWithImpl<$R> extends BaseCopyWith<ScriptDef, $R> implements ScriptDefCopyWith<$R> {
  _ScriptDefCopyWithImpl(ScriptDef value, Then<ScriptDef, $R> then) : super(value, then);

  @override $R call({Object? js = _none}) => _then(ScriptDef(js: or(js, _value.js)));
}


// === GENERATED ENUM MAPPERS AND EXTENSIONS ===




// === GENERATED UTILITY CODE ===

class Mapper<T> {
  Mapper._();

  static T fromValue<T>(dynamic value) {
    if (value.runtimeType == T || value == null) {
      return value as T;
    } else {
      TypeInfo typeInfo;
      if (value is Map<String, dynamic> && value['__type'] != null) {
        typeInfo = TypeInfo.fromType(value['__type'] as String);
      } else {
        typeInfo = TypeInfo.fromType<T>();
      }
      var mapper = _mappers[typeInfo.type];
      if (mapper?.decoder != null) {
        try {
          return genericCall(typeInfo, mapper!.decoder!, value) as T;
        } catch (e) {
          throw MapperException('Error on decoding type $T: ${e is MapperException ? e.message : e}');
        }
      } else {
        throw MapperException('Cannot decode value $value of type ${value.runtimeType} to type $T. Unknown type. Did you forgot to include the class or register a custom mapper?');
      }
    }
  }

  static dynamic toValue(dynamic value) {
    if (value == null) return null;
    var typeInfo = TypeInfo.fromValue(value);
    var mapper = _mappers[typeInfo.type] ?? _mappers.values
      .cast<BaseMapper?>()
      .firstWhere((m) => m!.isFor(value), orElse: () => null);
    if (mapper != null && mapper.encoder != null) {
      var encoded = mapper.encoder!.call(value);
      if (encoded is Map<String, dynamic>) {
        _clearType(encoded);
        if (typeInfo.params.isNotEmpty) {
          typeInfo.type = _typeOf(mapper.type);
          encoded['__type'] = typeInfo.toString();
        }
      }
      return encoded;
    } else {
      throw MapperException('Cannot encode value $value of type ${value.runtimeType}. Unknown type. Did you forgot to include the class or register a custom mapper?');
    }
  }

  static T fromMap<T>(Map<String, dynamic> map) => fromValue<T>(map);

  static Map<String, dynamic> toMap(dynamic object) {
    var value = toValue(object);
    if (value is Map<String, dynamic>) {
      return value;
    } else {
      throw MapperException('Cannot encode value of type ${object.runtimeType} to Map. Instead encoded to type ${value.runtimeType}.');
    }
  }
  
  static T fromIterable<T>(Iterable<dynamic> iterable) => fromValue<T>(iterable);

  static Iterable<dynamic> toIterable(dynamic object) {
    var value = toValue(object);
    if (value is Iterable<dynamic>) {
      return value;
    } else {
      throw MapperException('Cannot encode value of type ${object.runtimeType} to Iterable. Instead encoded to type ${value.runtimeType}.');
    }
  }

  static T fromJson<T>(String json) {
    return fromValue<T>(jsonDecode(json));
  }
  
  static String toJson(dynamic object) {
    return jsonEncode(toValue(object));
  }

  static bool isEqual(dynamic value, Object? other) {
    if (value == null || other == null) {
      return value == other;
    } else if (value.runtimeType != other.runtimeType) {
      return false;
    }
    var type = TypeInfo.fromValue(value);
    return _mappers[type.type]?.equals(value, other) ?? value == other;
  }
  
  static int hash(dynamic value) {
    var type = TypeInfo.fromValue(value);
    return _mappers[type.type]?.hash(value) ?? value.hashCode;
  }

  static String asString(dynamic value) {
    var type = TypeInfo.fromValue(value);
    return _mappers[type.type]?.stringify(value) ?? value.toString();
  }

  static void use<T>(BaseMapper<T> mapper) => _mappers[_typeOf<T>()] = mapper;
  static BaseMapper<T>? unuse<T>() => _mappers.remove(_typeOf<T>()) as BaseMapper<T>?;
  static void useAll(List<BaseMapper> mappers) => _mappers.addEntries(mappers.map((m) => MapEntry(_typeOf(m.type), m)));
  
  static BaseMapper<T>? get<T>() => _mappers[_typeOf<T>()] as BaseMapper<T>?;
  static List<BaseMapper> getAll() => [..._mappers.values];
}

String _typeOf<T>([Type? t]) {
  var input = (t ?? T).toString();
  return input.split('<')[0];
}

void _clearType(Map<String, dynamic> map) {
  map.removeWhere((key, _) => key == '__type');
  map.values.whereType<Map<String, dynamic>>().forEach(_clearType);
  map.values.whereType<List>().forEach((l) => l.whereType<Map<String, dynamic>>().forEach(_clearType));
}

mixin Mappable {
  BaseMapper? get _mapper => _mappers[_typeOf(runtimeType)];

  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);

  @override String toString() => _mapper?.stringify(this) ?? super.toString();
  @override bool operator ==(Object other) => identical(this, other) || (runtimeType == other.runtimeType && (_mapper?.equals(this, other) ?? super == other));
  @override int get hashCode => _mapper?.hash(this) ?? super.hashCode;
}

T _checked<T, U>(dynamic v, T Function(U) fn) {
  if (v is U) {
    return fn(v);
  } else {
    throw MapperException('Cannot decode value of type ${v.runtimeType} to type $T, because a value of type $U is expected.');
  }
}

class DateTimeMapper extends SimpleMapper<DateTime> {

  @override
  DateTime decode(dynamic d) {
    if (d is String) {
      return DateTime.parse(d);
    } else if (d is num) {
      return DateTime.fromMillisecondsSinceEpoch(d.round());
    } else {
      throw MapperException('Cannot decode value of type ${d.runtimeType} to type DateTime, because a value of type String or num is expected.');
    }
  }
  
  @override
  String encode(DateTime self) {
    return self.toUtc().toIso8601String();
  }
}

class MapperEquality implements Equality {
  @override bool equals(dynamic e1, dynamic e2) => Mapper.isEqual(e1, e2);
  @override int hash(dynamic e) => Mapper.hash(e);
  @override bool isValidKey(Object? o) => true;
}

class IterableMapper<I extends Iterable> extends BaseMapper<I> with MapperEqualityMixin<I> {
  Iterable<U> Function<U>(Iterable<U> iterable) fromIterable;
  IterableMapper(this.fromIterable, this.typeFactory);

  @override Function get decoder => <T>(dynamic l) => _checked(l, (Iterable l) => fromIterable(l.map((v) => Mapper.fromValue<T>(v))));
  @override Function get encoder => (I self) => self.map((v) => Mapper.toValue(v)).toList();
  @override Function typeFactory;
  
  @override Equality equality = IterableEquality(MapperEquality());
}

class MapMapper<M extends Map> extends BaseMapper<M> with MapperEqualityMixin<M> {
  Map<K, V> Function<K, V>(Map<K, V> map) fromMap;
  MapMapper(this.fromMap, this.typeFactory);

  @override Function get decoder => <K, V>(dynamic m) => _checked(m,(Map m) => fromMap(m.map((key, value) => MapEntry(Mapper.fromValue<K>(key), Mapper.fromValue<V>(value)))));
  @override Function get encoder => (M self) => self.map((key, value) => MapEntry(Mapper.toValue(key), Mapper.toValue(value)));
  @override Function typeFactory;
  
  @override Equality equality = MapEquality(keys: MapperEquality(), values: MapperEquality());
}

class PrimitiveMapper<T> extends BaseMapper<T> {
  const PrimitiveMapper(this.decoder);
  
  @override final T Function(dynamic value) decoder;
  @override Function get encoder => (T value) => value;
  @override Function get typeFactory => (f) => f<T>();
  
  @override bool isFor(dynamic v) => v.runtimeType == T;
}

class EnumMapper<T> extends SimpleMapper<T> {
  EnumMapper(this._decoder, this._encoder);
  
  final T Function(String value) _decoder;
  final String Function(T value) _encoder;
  
  @override T decode(dynamic v) => _checked(v, _decoder);
  @override dynamic encode(T value) => _encoder(value);
}

dynamic genericCall(TypeInfo info, Function fn, dynamic value) {
  var params = [...info.params];

  dynamic call(dynamic Function<T>() next) {
    var t = params.removeAt(0);
    if (_mappers[t.type] != null) {
      return genericCall(t, _mappers[t.type]!.typeFactory ?? (f) => f(), next);
    } else {
      throw MapperException('Cannot find generic wrapper for type $t.');
    }
  }

  if (params.isEmpty) {
    return fn(value);
  } else if (params.length == 1) {
    return call(<A>() => fn<A>(value));
  } else if (params.length == 2) {
    return call(<A>() => call(<B>() => fn<A, B>(value)));
  } else if (params.length == 3) {
    return call(<A>() => call(<B>() => call(<C>() => fn<A, B, C>(value))));
  } else {
    throw MapperException('Cannot construct generic wrapper for type $info. Mapper only supports generic classes with up to 3 type arguments.');
  }
}

T _hookedDecode<T>(MappingHooks hooks, dynamic value, T Function(dynamic value) fn) {
  var v = hooks.beforeDecode(value);
  if (v is! T) v = fn(v);
  return hooks.afterDecode(v) as T;
}
dynamic _hookedEncode<T>(MappingHooks hooks, T value, dynamic Function(T value) fn) {
  var v = hooks.beforeEncode(value);
  if (v is T) v = fn(v);
  return hooks.afterEncode(v);
}

dynamic _toValue(dynamic value, {MappingHooks? hooks}) {
  if (hooks == null) {
    return Mapper.toValue(value);
  } else {
    return hooks.afterEncode(Mapper.toValue(hooks.beforeEncode(value)));
  }
}

extension MapGet on Map<String, dynamic> {
  T get<T>(String key, {MappingHooks? hooks}) => hooked(hooks, key, (v) {
    if (v == null) {
      throw MapperException('Parameter $key is required.');
    }
    return Mapper.fromValue<T>(v);
  });

  T? getOpt<T>(String key, {MappingHooks? hooks}) => hooked(hooks, key, (v) {
    if (v == null) {
      return null;
    }
    return Mapper.fromValue<T>(v);
  });

  List<T> getList<T>(String key, {MappingHooks? hooks}) => hooked(hooks, key, (v) {
    if (v == null) {
      throw MapperException('Parameter $key is required.');
    } else if (v is! List) {
      throw MapperException('Parameter $v with key $key is not a List');
    }
    return v.map((dynamic item) => Mapper.fromValue<T>(item)).toList();
  });

  List<T>? getListOpt<T>(String key, {MappingHooks? hooks}) => hooked(hooks, key, (v) {
    if (v == null) {
      return null;
    } else if (v is! List) {
      throw MapperException('Parameter $v with key $key is not a List');
    }
    return v.map((dynamic item) => Mapper.fromValue<T>(item)).toList();
  });

  Map<K, V> getMap<K, V>(String key, {MappingHooks? hooks}) => hooked(hooks, key, (v) {
    if (v == null) {
      throw MapperException('Parameter $key is required.');
    } else if (v is! Map) {
      throw MapperException('Parameter $v with key $key is not a Map');
    }
    return v.map((dynamic key, dynamic value) => MapEntry(Mapper.fromValue<K>(key), Mapper.fromValue<V>(value)));
  });

  Map<K, V>? getMapOpt<K, V>(String key, {MappingHooks? hooks}) => hooked(hooks, key, (v) {
    if (v == null) {
      return null;
    } else if (v is! Map) {
      throw MapperException('Parameter $v with key $key is not a Map');
    }
    return v.map((dynamic key, dynamic value) => MapEntry(Mapper.fromValue<K>(key), Mapper.fromValue<V>(value)));
  });

  T hooked<T>(MappingHooks? hooks, String key, T Function(dynamic v) fn) {
    if (hooks == null) {
      return fn(this[key]);
    } else {
      return hooks.afterDecode(fn(hooks.beforeDecode(this[key]))) as T;
    }
  }
}

class _None { const _None(); }
const _none = _None();

T _$identity<T>(T value) => value;
typedef Then<$T, $R> = $R Function($T);

class BaseCopyWith<$T, $R> {
  BaseCopyWith(this._value, this._then);

  final $T _value;
  final Then<$T, $R> _then;
  
  T or<T>(Object? _v, T v) => _v == _none ? v : _v as T;
}

class ListCopyWith<$R, $T, $C> extends BaseCopyWith<List<$T>, $R> {
  ListCopyWith(List<$T> value, this.itemCopyWith, Then<List<$T>, $R> then)
      : super(value, then);
  $C Function($T a, Then<$T, $R> b) itemCopyWith;

  $C at(int index) => itemCopyWith(_value[index], (v) => replace(index, v));

  $R add($T v) => addAll([v]);

  $R addAll(Iterable<$T> v) => _then([..._value, ...v]);

  $R replace(int index, $T v) => splice(index, 1, [v]);

  $R insert(int index, $T v) => insertAll(index, [v]);

  $R insertAll(int index, Iterable<$T> v) => splice(index, 0, v);

  $R removeAt(int index) => splice(index, 1);

  $R splice(int index, int removeCount, [Iterable<$T>? toInsert]) => _then([
        ..._value.take(index),
        if (toInsert != null) ...toInsert,
        ..._value.skip(index + removeCount),
      ]);

  $R take(int count) => _then(_value.take(count).toList());

  $R skip(int count) => _then(_value.skip(count).toList());

  $R where(bool Function($T) test) => _then(_value.where(test).toList());

  $R sublist(int start, [int? end]) => _then(_value.sublist(start, end));
}

