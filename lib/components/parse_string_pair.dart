import 'package:autobot/common/exceptions.dart';
import 'package:autobot/common/types.dart';
import 'package:autobot/common/collection_util.dart';
import 'package:dcli/dcli.dart';

Pair<String, String> parseStringPair(String stringPair) {
  final pair = stringPair.split('=');
  if (pair.length != 2) {
    throw TellUser((tell) => tell(red("Only one '=' per key value pair ")));
  }

  final key = pair[0].trim();
  final value = pair[1].trim();
  return Pair(key: key, value: value);
}

Map<String, String> parseStringPairs(List<String> stringPairs) {
  return stringPairs //
      .map(parseStringPair)
      .toList()
      .toMap(
        keyProvider: (pair) => pair.key,
        valueProvider: (pair) => pair.value,
      );
}
