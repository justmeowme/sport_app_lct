import 'package:sport_app_lct/models/exercise.dart';

class Classes {
  final int courseId;
  final String cover;
  final String description;
  final int id;
  final List<Exercise> exercises;
  final String title;

  Classes({
    required this.courseId,
    this.cover = "",
    this.description = "",
    this.id = 0,
    this.exercises = const [],
    required this.title,
  });

  factory Classes.fromJson(Map<String, dynamic> json) {
    return Classes(
      courseId: json['course_id'] ?? 0,
      cover: json['cover'] ?? "",
      description: json['description'] ?? "",
      id: json['id'] ?? 0,
      exercises: json['lessons'] == null ? [] : (json['lessons'][0]['exercises'] as List<dynamic>)
          .map((lesson) => Exercise.fromJson(lesson as Map<String, dynamic>))
          .toList(),
      title: json['title'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course_id': courseId,
      'cover': cover,
      'description': description,
      'id': id,
      'lessons': [
        {
          'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
        }
      ],
      'title': title,
    };
  }

  Classes copyWith({
    int? courseId,
    String? cover,
    String? description,
    int? id,
    List<Exercise>? exercises,
    String? title,
  }) {
    return Classes(
      courseId: courseId ?? this.courseId,
      cover: cover ?? this.cover,
      description: description ?? this.description,
      id: id ?? this.id,
      exercises: exercises ?? this.exercises,
      title: title ?? this.title,
    );
  }
}
