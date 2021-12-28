import 'package:autobot/common/exceptions.dart';
import 'package:autobot/common/types.dart';
import 'package:autobot/components/parse_string_pair.dart';
import 'package:autobot/tell.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    TellManager.clearPrints();
  });

  test('parsePair() -> Parses string pairs.', () {
    expect(parseStringPair('a=b'), Pair(key: 'a', value: 'b'));
    expect(() => parseStringPair('a=b=c'), throwsA(isA<TellUser>()));

    expect(parseStringPairs(['a=b', 'cd=ef']), {'a': 'b', 'cd': 'ef'});
    expect(() => parseStringPairs(['a=b', 'cd=e=f']), throwsA(isA<TellUser>()));
  });
}
