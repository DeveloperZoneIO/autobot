part of '../run.dart';

extension StringBoolean on String {
  bool get meansTrue =>
      toLowerCase().trim() == 'true' ||
      toLowerCase().trim() == 'yes' ||
      toLowerCase().trim() == 'y';
  bool get meansFalse => !meansTrue;
}
