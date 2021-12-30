import 'package:autobot/common/exceptions.dart';
import 'package:autobot/common/types.dart';
import 'package:autobot/common/collection_util.dart';
import 'package:dcli/dcli.dart';

/// Parses a key-value string and returns the [Pair] representation.
/// A key-value string looks like:
/// ```dart
/// "someKey=someValue"
/// ```
Pair<String, String> parsePair(String pair) {
  final pairElements = pair.split('=');
  if (pairElements.length != 2) {
    throw TellUser((tell) => tell(red("Only one '=' per key value pair ")));
  }

  final key = pairElements[0].trim();
  final value = pairElements[1].trim();
  return Pair(key: key, value: value);
}

/// Parses a list of key-value strings and returns a list of the [Pair] representations.
/// A key-value string looks like:
/// ```dart
/// "someKey=someValue"
/// ```
Map<String, String> parsePairs(List<String> pairs) {
  return pairs //
      .map(parsePair)
      .toList()
      .toMap((pairObject) => pairObject);
}
