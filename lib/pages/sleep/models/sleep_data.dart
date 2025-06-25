class SleepData {
  final DateTime bedTime;
  final DateTime wakeUpTime;
  final Duration sleepDuration;
  final DateTime createdAt;

  SleepData({
    required this.bedTime,
    required this.wakeUpTime,
    DateTime? createdAt,
  }) : sleepDuration = wakeUpTime.difference(bedTime),
       createdAt = createdAt ?? DateTime.now();

  String get formattedBedTime =>
      '${bedTime.day}/${bedTime.month}/${bedTime.year} at ${bedTime.hour.toString().padLeft(2, '0')}:${bedTime.minute.toString().padLeft(2, '0')}';

  String get formattedWakeUpTime =>
      '${wakeUpTime.day}/${wakeUpTime.month}/${wakeUpTime.year} at ${wakeUpTime.hour.toString().padLeft(2, '0')}:${wakeUpTime.minute.toString().padLeft(2, '0')}';

  String get formattedDuration {
    int hours = sleepDuration.inHours;
    int minutes = sleepDuration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  bool get isValidSleep => wakeUpTime.isAfter(bedTime);

  Map<String, dynamic> toJson() {
    return {
      'bedTime': bedTime.toIso8601String(),
      'wakeUpTime': wakeUpTime.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory SleepData.fromJson(Map<String, dynamic> json) {
    return SleepData(
      bedTime: DateTime.parse(json['bedTime']),
      wakeUpTime: DateTime.parse(json['wakeUpTime']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
