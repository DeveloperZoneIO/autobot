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
  _typeOf<MetaNode>(): MetaNodeMapper._(),
  _typeOf<StepNode>(): StepNodeMapper._(),
  _typeOf<AskStep>(): AskStepMapper._(),
  _typeOf<VariablesStep>(): VariablesStepMapper._(),
  _typeOf<ReadStep>(): ReadStepMapper._(),
  _typeOf<JavascriptStep>(): JavascriptStepMapper._(),
  _typeOf<ShellScriptStep>(): ShellScriptStepMapper._(),
  _typeOf<WriteStep>(): WriteStepMapper._(),
  _typeOf<RunTaskStep>(): RunTaskStepMapper._(),
  // enum mappers
  // custom mappers
};


// === GENERATED CLASS MAPPERS AND EXTENSIONS ===

class MetaNodeMapper extends BaseMapper<MetaNode> {
  MetaNodeMapper._();

  @override Function get decoder => decode;
  MetaNode decode(dynamic v) => _checked(v, (Map<String, dynamic> map) => fromMap(map));
  MetaNode fromMap(Map<String, dynamic> map) => MetaNode(map.getOpt('title'), map.getOpt('description'));

  @override Function get encoder => (MetaNode v) => encode(v);
  dynamic encode(MetaNode v) => toMap(v);
  Map<String, dynamic> toMap(MetaNode m) => {if (Mapper.toValue(m.title) != null) 'title': Mapper.toValue(m.title), if (Mapper.toValue(m.description) != null) 'description': Mapper.toValue(m.description)};

  @override String? stringify(MetaNode self) => 'MetaNode(title: ${Mapper.asString(self.title)}, description: ${Mapper.asString(self.description)})';
  @override int? hash(MetaNode self) => Mapper.hash(self.title) ^ Mapper.hash(self.description);
  @override bool? equals(MetaNode self, MetaNode other) => Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.description, other.description);

  @override Function get typeFactory => (f) => f<MetaNode>();
}

extension MetaNodeMapperExtension on MetaNode {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  MetaNodeCopyWith<MetaNode> get copyWith => MetaNodeCopyWith(this, _$identity);
}

abstract class MetaNodeCopyWith<$R> {
  factory MetaNodeCopyWith(MetaNode value, Then<MetaNode, $R> then) = _MetaNodeCopyWithImpl<$R>;
  $R call({String? title, String? description});
}

class _MetaNodeCopyWithImpl<$R> extends BaseCopyWith<MetaNode, $R> implements MetaNodeCopyWith<$R> {
  _MetaNodeCopyWithImpl(MetaNode value, Then<MetaNode, $R> then) : super(value, then);

  @override $R call({Object? title = _none, Object? description = _none}) => _then(MetaNode(or(title, _value.title), or(description, _value.description)));
}

class StepNodeMapper extends BaseMapper<StepNode> {
  StepNodeMapper._();

  @override Function get decoder => decode;
  StepNode decode(dynamic v) => _checked(v, (Map<String, dynamic> map) {
    switch(map['type']) {
      case 'AskStep': return AskStepMapper._().decode(map);
      case 'JavascriptStep': return JavascriptStepMapper._().decode(map);
      case 'ReadStep': return ReadStepMapper._().decode(map);
      case 'RunTaskStep': return RunTaskStepMapper._().decode(map);
      case 'ShellScriptStep': return ShellScriptStepMapper._().decode(map);
      case 'VariablesStep': return VariablesStepMapper._().decode(map);
      case 'WriteStep': return WriteStepMapper._().decode(map);
      default: return fromMap(map);
    }
  });
  StepNode fromMap(Map<String, dynamic> map) => throw MapperException("Cannot instantiate class StepNode, did you forgot to specify a subclass for [ type: '${map['type']}' ] or a default subclass?");

  @override Function get encoder => (StepNode v) => encode(v);
  dynamic encode(StepNode v) {
    if (v is AskStep) { return AskStepMapper._().encode(v); }
    else if (v is VariablesStep) { return VariablesStepMapper._().encode(v); }
    else if (v is ReadStep) { return ReadStepMapper._().encode(v); }
    else if (v is JavascriptStep) { return JavascriptStepMapper._().encode(v); }
    else if (v is ShellScriptStep) { return ShellScriptStepMapper._().encode(v); }
    else if (v is WriteStep) { return WriteStepMapper._().encode(v); }
    else if (v is RunTaskStep) { return RunTaskStepMapper._().encode(v); }
    else { return toMap(v); }
  }
  Map<String, dynamic> toMap(StepNode s) => {};

  @override String? stringify(StepNode self) => 'StepNode()';
  @override int? hash(StepNode self) => self.hashCode;
  @override bool? equals(StepNode self, StepNode other) => true;

  @override Function get typeFactory => (f) => f<StepNode>();
}

extension StepNodeMapperExtension on StepNode {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
}

class AskStepMapper extends BaseMapper<AskStep> {
  AskStepMapper._();

  @override Function get decoder => decode;
  AskStep decode(dynamic v) => _checked(v, (Map<String, dynamic> map) => fromMap(map));
  AskStep fromMap(Map<String, dynamic> map) => AskStep(map.get('key'), map.get('prompt'));

  @override Function get encoder => (AskStep v) => encode(v);
  dynamic encode(AskStep v) => toMap(v);
  Map<String, dynamic> toMap(AskStep a) => {'key': Mapper.toValue(a.key), 'prompt': Mapper.toValue(a.prompt), 'type': 'AskStep'};

  @override String? stringify(AskStep self) => 'AskStep(key: ${Mapper.asString(self.key)}, prompt: ${Mapper.asString(self.prompt)})';
  @override int? hash(AskStep self) => Mapper.hash(self.key) ^ Mapper.hash(self.prompt);
  @override bool? equals(AskStep self, AskStep other) => Mapper.isEqual(self.key, other.key) && Mapper.isEqual(self.prompt, other.prompt);

  @override Function get typeFactory => (f) => f<AskStep>();
}

extension AskStepMapperExtension on AskStep {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  AskStepCopyWith<AskStep> get copyWith => AskStepCopyWith(this, _$identity);
}

abstract class AskStepCopyWith<$R> {
  factory AskStepCopyWith(AskStep value, Then<AskStep, $R> then) = _AskStepCopyWithImpl<$R>;
  $R call({String? key, String? prompt});
}

class _AskStepCopyWithImpl<$R> extends BaseCopyWith<AskStep, $R> implements AskStepCopyWith<$R> {
  _AskStepCopyWithImpl(AskStep value, Then<AskStep, $R> then) : super(value, then);

  @override $R call({String? key, String? prompt}) => _then(AskStep(key ?? _value.key, prompt ?? _value.prompt));
}

class VariablesStepMapper extends BaseMapper<VariablesStep> {
  VariablesStepMapper._();

  @override Function get decoder => decode;
  VariablesStep decode(dynamic v) => _checked(v, (Map<String, dynamic> map) => fromMap(map));
  VariablesStep fromMap(Map<String, dynamic> map) => VariablesStep(map.getList('vars'));

  @override Function get encoder => (VariablesStep v) => encode(v);
  dynamic encode(VariablesStep v) => toMap(v);
  Map<String, dynamic> toMap(VariablesStep v) => {'vars': Mapper.toValue(v.vars), 'type': 'VariablesStep'};

  @override String? stringify(VariablesStep self) => 'VariablesStep(vars: ${Mapper.asString(self.vars)})';
  @override int? hash(VariablesStep self) => Mapper.hash(self.vars);
  @override bool? equals(VariablesStep self, VariablesStep other) => Mapper.isEqual(self.vars, other.vars);

  @override Function get typeFactory => (f) => f<VariablesStep>();
}

extension VariablesStepMapperExtension on VariablesStep {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  VariablesStepCopyWith<VariablesStep> get copyWith => VariablesStepCopyWith(this, _$identity);
}

abstract class VariablesStepCopyWith<$R> {
  factory VariablesStepCopyWith(VariablesStep value, Then<VariablesStep, $R> then) = _VariablesStepCopyWithImpl<$R>;
  $R call({List<Map<String, dynamic>>? vars});
}

class _VariablesStepCopyWithImpl<$R> extends BaseCopyWith<VariablesStep, $R> implements VariablesStepCopyWith<$R> {
  _VariablesStepCopyWithImpl(VariablesStep value, Then<VariablesStep, $R> then) : super(value, then);

  @override $R call({List<Map<String, dynamic>>? vars}) => _then(VariablesStep(vars ?? _value.vars));
}

class ReadStepMapper extends BaseMapper<ReadStep> {
  ReadStepMapper._();

  @override Function get decoder => decode;
  ReadStep decode(dynamic v) => _checked(v, (Map<String, dynamic> map) => fromMap(map));
  ReadStep fromMap(Map<String, dynamic> map) => ReadStep(map.get('file'), map.get('required'));

  @override Function get encoder => (ReadStep v) => encode(v);
  dynamic encode(ReadStep v) => toMap(v);
  Map<String, dynamic> toMap(ReadStep r) => {'file': Mapper.toValue(r.file), 'required': Mapper.toValue(r.required), 'type': 'ReadStep'};

  @override String? stringify(ReadStep self) => 'ReadStep(file: ${Mapper.asString(self.file)}, required: ${Mapper.asString(self.required)})';
  @override int? hash(ReadStep self) => Mapper.hash(self.file) ^ Mapper.hash(self.required);
  @override bool? equals(ReadStep self, ReadStep other) => Mapper.isEqual(self.file, other.file) && Mapper.isEqual(self.required, other.required);

  @override Function get typeFactory => (f) => f<ReadStep>();
}

extension ReadStepMapperExtension on ReadStep {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  ReadStepCopyWith<ReadStep> get copyWith => ReadStepCopyWith(this, _$identity);
}

abstract class ReadStepCopyWith<$R> {
  factory ReadStepCopyWith(ReadStep value, Then<ReadStep, $R> then) = _ReadStepCopyWithImpl<$R>;
  $R call({String? file, bool? required});
}

class _ReadStepCopyWithImpl<$R> extends BaseCopyWith<ReadStep, $R> implements ReadStepCopyWith<$R> {
  _ReadStepCopyWithImpl(ReadStep value, Then<ReadStep, $R> then) : super(value, then);

  @override $R call({String? file, bool? required}) => _then(ReadStep(file ?? _value.file, required ?? _value.required));
}

class JavascriptStepMapper extends BaseMapper<JavascriptStep> {
  JavascriptStepMapper._();

  @override Function get decoder => decode;
  JavascriptStep decode(dynamic v) => _checked(v, (Map<String, dynamic> map) => fromMap(map));
  JavascriptStep fromMap(Map<String, dynamic> map) => JavascriptStep(map.get('runJavascript'));

  @override Function get encoder => (JavascriptStep v) => encode(v);
  dynamic encode(JavascriptStep v) => toMap(v);
  Map<String, dynamic> toMap(JavascriptStep j) => {'runJavascript': Mapper.toValue(j.run_javascript), 'type': 'JavascriptStep'};

  @override String? stringify(JavascriptStep self) => 'JavascriptStep(run_javascript: ${Mapper.asString(self.run_javascript)})';
  @override int? hash(JavascriptStep self) => Mapper.hash(self.run_javascript);
  @override bool? equals(JavascriptStep self, JavascriptStep other) => Mapper.isEqual(self.run_javascript, other.run_javascript);

  @override Function get typeFactory => (f) => f<JavascriptStep>();
}

extension JavascriptStepMapperExtension on JavascriptStep {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  JavascriptStepCopyWith<JavascriptStep> get copyWith => JavascriptStepCopyWith(this, _$identity);
}

abstract class JavascriptStepCopyWith<$R> {
  factory JavascriptStepCopyWith(JavascriptStep value, Then<JavascriptStep, $R> then) = _JavascriptStepCopyWithImpl<$R>;
  $R call({String? run_javascript});
}

class _JavascriptStepCopyWithImpl<$R> extends BaseCopyWith<JavascriptStep, $R> implements JavascriptStepCopyWith<$R> {
  _JavascriptStepCopyWithImpl(JavascriptStep value, Then<JavascriptStep, $R> then) : super(value, then);

  @override $R call({String? run_javascript}) => _then(JavascriptStep(run_javascript ?? _value.run_javascript));
}

class ShellScriptStepMapper extends BaseMapper<ShellScriptStep> {
  ShellScriptStepMapper._();

  @override Function get decoder => decode;
  ShellScriptStep decode(dynamic v) => _checked(v, (Map<String, dynamic> map) => fromMap(map));
  ShellScriptStep fromMap(Map<String, dynamic> map) => ShellScriptStep(map.get('runCommand'));

  @override Function get encoder => (ShellScriptStep v) => encode(v);
  dynamic encode(ShellScriptStep v) => toMap(v);
  Map<String, dynamic> toMap(ShellScriptStep s) => {'runCommand': Mapper.toValue(s.run_command), 'type': 'ShellScriptStep'};

  @override String? stringify(ShellScriptStep self) => 'ShellScriptStep(run_command: ${Mapper.asString(self.run_command)})';
  @override int? hash(ShellScriptStep self) => Mapper.hash(self.run_command);
  @override bool? equals(ShellScriptStep self, ShellScriptStep other) => Mapper.isEqual(self.run_command, other.run_command);

  @override Function get typeFactory => (f) => f<ShellScriptStep>();
}

extension ShellScriptStepMapperExtension on ShellScriptStep {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  ShellScriptStepCopyWith<ShellScriptStep> get copyWith => ShellScriptStepCopyWith(this, _$identity);
}

abstract class ShellScriptStepCopyWith<$R> {
  factory ShellScriptStepCopyWith(ShellScriptStep value, Then<ShellScriptStep, $R> then) = _ShellScriptStepCopyWithImpl<$R>;
  $R call({String? run_command});
}

class _ShellScriptStepCopyWithImpl<$R> extends BaseCopyWith<ShellScriptStep, $R> implements ShellScriptStepCopyWith<$R> {
  _ShellScriptStepCopyWithImpl(ShellScriptStep value, Then<ShellScriptStep, $R> then) : super(value, then);

  @override $R call({String? run_command}) => _then(ShellScriptStep(run_command ?? _value.run_command));
}

class WriteStepMapper extends BaseMapper<WriteStep> {
  WriteStepMapper._();

  @override Function get decoder => decode;
  WriteStep decode(dynamic v) => _checked(v, (Map<String, dynamic> map) => fromMap(map));
  WriteStep fromMap(Map<String, dynamic> map) => WriteStep(map.get('path'), map.get('content'), writeMethod: map.getOpt('writeMethod') ?? 'default', enabled: map.getOpt('enabled') ?? 'yes', extendAt: map.getOpt('extendAt') ?? 'bottom');

  @override Function get encoder => (WriteStep v) => encode(v);
  dynamic encode(WriteStep v) => toMap(v);
  Map<String, dynamic> toMap(WriteStep w) => {'path': Mapper.toValue(w.path), 'content': Mapper.toValue(w.content), 'writeMethod': Mapper.toValue(w.writeMethod), 'enabled': Mapper.toValue(w.enabled), 'extendAt': Mapper.toValue(w.extendAt), 'type': 'WriteStep'};

  @override String? stringify(WriteStep self) => 'WriteStep(path: ${Mapper.asString(self.path)}, content: ${Mapper.asString(self.content)}, writeMethod: ${Mapper.asString(self.writeMethod)}, enabled: ${Mapper.asString(self.enabled)}, extendAt: ${Mapper.asString(self.extendAt)})';
  @override int? hash(WriteStep self) => Mapper.hash(self.path) ^ Mapper.hash(self.content) ^ Mapper.hash(self.writeMethod) ^ Mapper.hash(self.enabled) ^ Mapper.hash(self.extendAt);
  @override bool? equals(WriteStep self, WriteStep other) => Mapper.isEqual(self.path, other.path) && Mapper.isEqual(self.content, other.content) && Mapper.isEqual(self.writeMethod, other.writeMethod) && Mapper.isEqual(self.enabled, other.enabled) && Mapper.isEqual(self.extendAt, other.extendAt);

  @override Function get typeFactory => (f) => f<WriteStep>();
}

extension WriteStepMapperExtension on WriteStep {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  WriteStepCopyWith<WriteStep> get copyWith => WriteStepCopyWith(this, _$identity);
}

abstract class WriteStepCopyWith<$R> {
  factory WriteStepCopyWith(WriteStep value, Then<WriteStep, $R> then) = _WriteStepCopyWithImpl<$R>;
  $R call({String? path, String? content, String? writeMethod, String? enabled, String? extendAt});
}

class _WriteStepCopyWithImpl<$R> extends BaseCopyWith<WriteStep, $R> implements WriteStepCopyWith<$R> {
  _WriteStepCopyWithImpl(WriteStep value, Then<WriteStep, $R> then) : super(value, then);

  @override $R call({String? path, String? content, String? writeMethod, String? enabled, String? extendAt}) => _then(WriteStep(path ?? _value.path, content ?? _value.content, writeMethod: writeMethod ?? _value.writeMethod, enabled: enabled ?? _value.enabled, extendAt: extendAt ?? _value.extendAt));
}

class RunTaskStepMapper extends BaseMapper<RunTaskStep> {
  RunTaskStepMapper._();

  @override Function get decoder => decode;
  RunTaskStep decode(dynamic v) => _checked(v, (Map<String, dynamic> map) => fromMap(map));
  RunTaskStep fromMap(Map<String, dynamic> map) => RunTaskStep(map.get('file'));

  @override Function get encoder => (RunTaskStep v) => encode(v);
  dynamic encode(RunTaskStep v) => toMap(v);
  Map<String, dynamic> toMap(RunTaskStep r) => {'file': Mapper.toValue(r.file), 'type': 'RunTaskStep'};

  @override String? stringify(RunTaskStep self) => 'RunTaskStep(file: ${Mapper.asString(self.file)})';
  @override int? hash(RunTaskStep self) => Mapper.hash(self.file);
  @override bool? equals(RunTaskStep self, RunTaskStep other) => Mapper.isEqual(self.file, other.file);

  @override Function get typeFactory => (f) => f<RunTaskStep>();
}

extension RunTaskStepMapperExtension on RunTaskStep {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  RunTaskStepCopyWith<RunTaskStep> get copyWith => RunTaskStepCopyWith(this, _$identity);
}

abstract class RunTaskStepCopyWith<$R> {
  factory RunTaskStepCopyWith(RunTaskStep value, Then<RunTaskStep, $R> then) = _RunTaskStepCopyWithImpl<$R>;
  $R call({String? file});
}

class _RunTaskStepCopyWithImpl<$R> extends BaseCopyWith<RunTaskStep, $R> implements RunTaskStepCopyWith<$R> {
  _RunTaskStepCopyWithImpl(RunTaskStep value, Then<RunTaskStep, $R> then) : super(value, then);

  @override $R call({String? file}) => _then(RunTaskStep(file ?? _value.file));
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

