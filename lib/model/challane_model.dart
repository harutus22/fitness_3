import 'dart:convert';

const challengeId = "challenge_id";
const challengeName = "challenge_name";
const challengeIsPassed = "challenge_is_passed";
const challengeImage = "challenge_image";
const challengeDate = "challenge_date";

class ChallengeModel{
  int? id;
  String? name;
  List<IsChallengePassed>? isPassed;
  String? image;
  DateTime? startDate;

  ChallengeModel({
    required this.name,
    required this.isPassed,
    required this.image,
    required this.startDate
});

  Map<String, Object?> toMap() {
    final list = [];
    isPassed?.forEach((element) {
      list.add(element.index);
    });
    var map = <String, Object?>{
      challengeId: id,
      challengeName: name,
      challengeIsPassed: jsonEncode(list),
      challengeImage: image,
      challengeDate: startDate?.toIso8601String()
    };
    return map;
  }

  ChallengeModel.fromMap(Map<dynamic, dynamic> map) {
    final item = map[challengeId];
    id = item == null ? 0 : item as int;
    name = map[challengeName] as String;
    isPassed = getList(jsonDecode(map[challengeIsPassed]));
    image = map[challengeImage] as String;
    startDate = DateTime.parse((map[challengeDate] as String));
  }

  List<IsChallengePassed> getList(List<dynamic> a){
    List<IsChallengePassed>list = [];
    for(final item in a){
      list.add(IsChallengePassed.values[item]);
    }
    return list;
  }
}

enum IsChallengePassed{
  completed,
  following,
  missed
}