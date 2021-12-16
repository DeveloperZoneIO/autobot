part of '../run.dart';

extension StringBoolean on String {
  bool get meansYes => toLowerCase().trim() == 'true' || toLowerCase().trim() == 'yes' || toLowerCase().trim() == 'y';
  bool get meansNo => !meansYes;
}
