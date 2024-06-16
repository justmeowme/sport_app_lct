import 'class.dart';

class Course {
  final int id;
  final String title;
  final String description;
  final String direction;
  final int difficultyNumeric;
  final String difficulty;
  final int cost;
  final int participantsCount;
  final int rating;
  final String requiredTools;
  final int trainerId;
  final List<Class> classes;

  Course({
    required this.id,
    required this.title,
    required this.description,
    this.direction = "",
    required this.difficultyNumeric,
    required this.difficulty,
    this.cost = 0,
    this.participantsCount = 0,
    this.rating = 0,
    this.requiredTools = "",
    required this.trainerId,
    required this.classes,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      direction: json['direction'],
      difficultyNumeric: json['difficulty_numeric'],
      difficulty: json['difficulty'],
      cost: json['cost'],
      participantsCount: json['participants_count'],
      rating: json['rating'],
      requiredTools: json['required_tools'],
      trainerId: json['trainer_id'],
      classes: json['classes'] != null ? (json['classes'] as List).map((i) => Class.fromJson(i)).toList() : <Class>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'direction': direction,
      'difficulty_numeric': difficultyNumeric,
      'difficulty': difficulty,
      'cost': cost,
      'participants_count': participantsCount,
      'rating': rating,
      'required_tools': requiredTools,
      'trainer_id': trainerId,
      'classes': classes.map((c) => c.toJson()).toList(),
    };
  }

  Course copyWith({
    int? id,
    String? title,
    String? description,
    String? direction,
    int? difficultyNumeric,
    String? difficulty,
    int? cost,
    int? participantsCount,
    int? rating,
    String? requiredTools,
    int? trainerId,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Class>? classes,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      direction: direction ?? this.direction,
      difficultyNumeric: difficultyNumeric ?? this.difficultyNumeric,
      difficulty: difficulty ?? this.difficulty,
      cost: cost ?? this.cost,
      participantsCount: participantsCount ?? this.participantsCount,
      rating: rating ?? this.rating,
      requiredTools: requiredTools ?? this.requiredTools,
      trainerId: trainerId ?? this.trainerId,
      classes: classes ?? this.classes,
    );
  }
}
