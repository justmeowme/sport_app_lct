import 'package:sport_app_lct/models/photo.dart';

class Exercise {
  final String? additionalMuscle;
  final String? createdAt;
  final String? difficulty;
  final String? equipment;
  final int id;
  final String muscle;
  final String name;
  final String? originalUri;
  final List<Photo>? photos;
  final String? type;
  final String? updatedAt;
  final int duration;

  Exercise({
    this.additionalMuscle,
    this.createdAt,
    this.difficulty,
    this.equipment,
    this.id = 0,
    required this.muscle,
    required this.name,
    this.originalUri,
    this.photos,
    this.type,
    this.updatedAt,
    this.duration = 0,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    var photosFromJson = json['photos'] as List;
    List<Photo> photosList = photosFromJson.map((i) => Photo.fromJson(i)).toList();

    return Exercise(
      additionalMuscle: json['additional_muscle'],
      createdAt: json['created_at'],
      difficulty: json['difficulty'],
      equipment: json['equipment'],
      id: json['id'] ?? 0,
      muscle: json['muscle'] ?? "",
      name: json['name'] ?? "",
      originalUri: json['original_uri'],
      photos: photosList,
      type: json['type'],
      updatedAt: json['updated_at'],
      duration: json['duration'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'additional_muscle': additionalMuscle,
      'created_at': createdAt,
      'difficulty': difficulty,
      'equipment': equipment,
      'id': id,
      'muscle': muscle,
      'name': name,
      'original_uri': originalUri,
      'photosList': photos != null ? photos?.map((e) => e.toJson()).toList() : [],
      'type': type,
      'updated_at': updatedAt,
      'duration': duration,
    };
  }

  Exercise copyWith({
    String? additionalMuscle,
    String? createdAt,
    String? difficulty,
    String? equipment,
    int? id,
    String? muscle,
    String? name,
    String? originalUri,
    List<Photo>? photos,
    String? type,
    String? updatedAt,
    int? duration,
  }) {
    return Exercise(
      additionalMuscle: additionalMuscle ?? this.additionalMuscle,
      createdAt: createdAt ?? this.createdAt,
      difficulty: difficulty ?? this.difficulty,
      equipment: equipment ?? this.equipment,
      id: id ?? this.id,
      muscle: muscle ?? this.muscle,
      name: name ?? this.name,
      originalUri: originalUri ?? this.originalUri,
      photos: photos ?? this.photos,
      type: type ?? this.type,
      updatedAt: updatedAt ?? this.updatedAt,
      duration: duration ?? this.duration,
    );
  }
}
