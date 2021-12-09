extension StringUtil on String {
  String stripMargin() {
    return splitMapJoin(
      RegExp(r'^', multiLine: true),
      onMatch: (_) => '\n',
      onNonMatch: (n) => n.trim(),
    );
  }
}
