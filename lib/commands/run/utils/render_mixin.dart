part of '../run.dart';

mixin TextRenderable {
  final renderVariables = <String, dynamic>{};
  String render(String value) => Template(value, lenient: true).renderString(renderVariables);
}
