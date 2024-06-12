class Shedule {
  final int coachId;
  final int clientId;
  final String date;
  final String startTime;
  final String endTime;
  final String type;
  final bool reminderCoach;
  final bool reminderClient;
  final bool isGlobal;

  Shedule({
    required this.coachId,
    required this.clientId,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.type = '',
    this.reminderCoach = false,
    this.reminderClient = false,
    this.isGlobal = false,
  });

  factory Shedule.fromJson(Map<String, dynamic> json) {
    return Shedule(
      coachId: json['coach_id'],
      clientId: json['client_id'],
      date: json['date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      type: json['type'] ?? '',
      reminderCoach: json['reminder_coach'] ?? false,
      reminderClient: json['reminder_client'] ?? false,
      isGlobal: json['is_global'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coach_id': coachId,
      'client_id': clientId,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'type': type,
      'reminder_coach': reminderCoach,
      'reminder_client': reminderClient,
      'is_global': isGlobal,
    };
  }

  Shedule copyWith({
    int? coachId,
    int? clientId,
    String? date,
    String? startTime,
    String? endTime,
    String? type,
    bool? reminderCoach,
    bool? reminderClient,
    bool? isGlobal,
  }) {
    return Shedule(
      coachId: coachId ?? this.coachId,
      clientId: clientId ?? this.clientId,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      type: type ?? this.type,
      reminderCoach: reminderCoach ?? this.reminderCoach,
      reminderClient: reminderClient ?? this.reminderClient,
      isGlobal: isGlobal ?? this.isGlobal,
    );
  }
}