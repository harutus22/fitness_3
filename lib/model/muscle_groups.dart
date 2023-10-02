import 'package:easy_localization/easy_localization.dart';

import '../utils/words.dart';

enum MuscleGroups {
  chestGroup,
  armsGroup,
  shouldersGroup,
  absGroup,
  legsGroup,
  buttocksGroup,
  backGroup;

  String get value{
    switch(this) {
      case MuscleGroups.chestGroup:
        return chest.tr();
      case MuscleGroups.armsGroup:
        return arms.tr();
      case MuscleGroups.shouldersGroup:
        return shoulders.tr();
      case MuscleGroups.absGroup:
        return abs.tr();
      case MuscleGroups.legsGroup:
        return legs.tr();
      case MuscleGroups.buttocksGroup:
        return buttocks.tr();
      case MuscleGroups.backGroup:
        return back.tr();
      default:
        return "";
    }
  }

  Map toJson() => {'muscle_group': name};
  MuscleGroups fromJson(String json) => values.byName(json);
}