
// "day": 30.29,
// "night": 24.53,
// "eve": 29.06,
// "morn": 23.26

class DailyFeelsLike {
  double day;

  double night;

  double eve;

  double morn;

  DailyFeelsLike({
    required this.day,
    required this.eve,
    required this.morn,
    required this.night,
  });

  factory DailyFeelsLike.fromJson(Map<String, dynamic> json) =>
      DailyFeelsLike(
        day: (json['day'] as num?)?.toDouble() ?? 0.0,
        eve: (json['eve'] as num?)?.toDouble() ?? 0.0,
        morn: (json['morn'] as num?)?.toDouble() ?? 0.0,
        night: (json['night'] as num?)?.toDouble() ?? 0.0,
      );

  @override
  String toString() {
    return '''
     day: $day,
     night: $night
     eve: $eve
     morn: $morn
    ''';
  }
}
