extension StringUtil on String {
  /// Strips the right empty space offset of a multiline string.
  String stripMargin({String reduce = '\t'}) {
    final lines = split('\n');
    var minIndent = -1;

    lines.forEach((line) {
      final chars = line.split('');
      final indentCount = chars.takeWhile((char) => char != reduce).length;
      if (minIndent < 0) minIndent = indentCount;
      if (indentCount < minIndent) minIndent = indentCount;
    });

    return lines.fold('', (value, line) {
      return value + line.replaceRange(0, minIndent, '') + '\n';
    });
  }
}
