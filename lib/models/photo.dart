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
}