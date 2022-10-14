import 'package:autobot/common/exceptions.dart';
import 'package:autobot/common/types.dart';
import 'package:autobot/components/parse_pair.dart';
import 'package:autobot/tell.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    TellManager.clearPrints();
  });

  test('parsePair() -> Parses string pairs.', () {
    expect(parsePair('a=b'), Pair(key: 'a', value: 'b'));
    expect(() => parsePair('a=b=c'), throwsA(isA<TellUser>()));

    expect(parseKeyValuePairs(['a=b', 'cd=ef']), {'a': 'b', 'cd': 'ef'});
    expect(() => parseKeyValuePairs(['a=b', 'cd=e=f']), throwsA(isA<TellUser>()));
  });
}
