import 'package:sport_app_lct/models/photo.dart';

class Exercise {
  final String additionalMuscle;
  final String createdAt;
  final String difficulty;
  final String equipment;
  final int id;
  final String muscle;
  final String name;
  final String originalUri;
  final List<Photo> photos;
  final String type;
  final String updatedAt;

  Exercise({
    required this.additionalMuscle,
    required this.createdAt,
    required this.difficulty,
    required this.equipment,
    required this.id,
    required this.muscle,
    required this.name,
    required this.originalUri,
    required this.photos,
    required this.type,
    required this.updatedAt,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    var photosFromJson = json['photos'] as List;
    List<Photo> photosList = photosFromJson.map((i) => Photo.fromJson(i)).toList();

    return Exercise(
      additionalMuscle: json['additional_muscle'],
      createdAt: json['created_at'],
      difficulty: json['difficulty'],
      equipment: json['equipment'],
      id: json['id'],
      muscle: json['muscle'],
      name: json['name'],
      originalUri: json['original_uri'],
      photos: photosList,
      type: json['type'],
      updatedAt: json['updated_at'],
    );
  }
}
