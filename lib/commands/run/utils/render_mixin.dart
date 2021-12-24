part of '../run.dart';

mixin TextRenderable {
  final _kMustacheVariableRegex = RegExp(r'{{.*}}|{{{.*}}}');

  final renderVariables = <String, dynamic>{};
  String render(String text) {
    String renderedText = text;

    while (true) {
      final hasMatch = _kMustacheVariableRegex.hasMatch(renderedText);
      if (hasMatch) {
        renderedText =
            Template(renderedText, lenient: true).renderString(renderVariables);
      } else {
        break;
      }
    }

    return renderedText;
  }
}
