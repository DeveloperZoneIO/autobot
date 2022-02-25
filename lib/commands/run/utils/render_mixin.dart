part of '../run.dart';

mixin TextRenderable {
  final _kMustacheVariableRegex = RegExp(r'{{.*}}|{{{.*}}}');

  final renderData = <String, dynamic>{};
  String render(String text) {
    String renderedText = text;

    while (true) {
      final hasMatch = _kMustacheVariableRegex.hasMatch(renderedText);
      if (hasMatch) {
        renderedText = Template(
          renderedText,
          lenient: true,
          htmlEscapeValues: false,
        ).renderString(renderData);
      } else {
        break;
      }
    }

    return renderedText;
  }
}
