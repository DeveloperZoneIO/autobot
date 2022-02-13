import 'dart:convert';

extension MapExtension on Map<String, dynamic> {
  Map<String, dynamic> unstringifyMapValues() {
    final compatibleVars = <String, dynamic>{};

    for (final entry in entries) {
      if (entry.value is! String) {
        compatibleVars[entry.key] = entry.value;
        continue;
      }

      try {
        compatibleVars[entry.key] = jsonDecode(entry.value);
      } catch (_) {
        compatibleVars[entry.key] = entry.value;
      }
    }

    return compatibleVars;
  }
}
