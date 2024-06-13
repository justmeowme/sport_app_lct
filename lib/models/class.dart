import 'package:sport_app_lct/models/image.dart';

class Class {
  final int id;
  final String title;
  final String description;
  final String content;
  final String cover;
  final String tips;
  final String video;
  final int courseId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Image> images;

  Class({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.cover,
    required this.tips,
    required this.video,
    required this.courseId,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      content: json['content'],
      cover: json['cover'],
      tips: json['tips'],
      video: json['video'],
      courseId: json['course_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      images: (json['images'] as List).map((i) => Image.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'cover': cover,
      'tips': tips,
      'video': video,
      'course_id': courseId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'images': images.map((i) => i.toJson()).toList(),
    };
  }
}
