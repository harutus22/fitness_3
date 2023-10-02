enum FocusArea {
  arm,
  chest,
  abs,
  leg,
  fullBody;

  Map toJson() => {'focus_are': name};
  FocusArea fromJson(String json) => values.byName(json);
}

enum MainGoal { loseWeight, buildMuscle, stayFit;
  Map toJson() => {'goal': name};
  MainGoal fromJson(String json) => values.byName(json);
}

enum Motivations {
  feelConfident,
  releaseStress,
  improveHealth,
  boostEnergy,
  getShaped;

  Map toJson() => {'motivation': name};
  Motivations fromJson(String json) => values.byName(json);
}

enum TrainingCount {
  noResult,
  less5Minute,
  from5To10,
  from10To15,
  from15To25,
  moreThan25;
  Map toJson() => {'count': name};
  TrainingCount fromJson(String json) => values.byName(json);
}

enum Gender { male, female;
  Map toJson() => {'gender': name};
  Gender fromJson(String json) => values.byName(json);
}
