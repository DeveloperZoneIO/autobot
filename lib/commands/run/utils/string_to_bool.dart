part of '../run.dart';

extension StringBoolean on String {
  bool isTrue() => toLowerCase() == 'true' || toLowerCase() == 'yes' || toLowerCase() == 'y';
  bool isFalse() => !isTrue();
}
