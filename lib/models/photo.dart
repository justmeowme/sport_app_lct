class Photo {
  final int exerciseId;
  final int id;
  final String url;

  Photo({
    required this.exerciseId,
    required this.id,
    required this.url,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      exerciseId: json['exercise_id'],
      id: json['id'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exercise_id': exerciseId,
      'id': id,
      'url': url,
    };
  }

  Photo copyWith({
    int? exerciseId,
    int? id,
    String? url,
  }) {
    return Photo(
      exerciseId: exerciseId ?? this.exerciseId,
      id: id ?? this.id,
      url: url ?? this.url,
    );
  }
}
