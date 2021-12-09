part of '../run.dart';

mixin TextRenderable {
  final renderVariables = <String, String>{};
  String render(String value) => Template(value, lenient: true).renderString(renderVariables);
}
