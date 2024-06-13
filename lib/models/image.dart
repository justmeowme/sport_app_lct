class Image {
  final int id;
  final int classId;
  final String image;

  Image({
    required this.id,
    required this.classId,
    required this.image,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['id'],
      classId: json['class_id'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'class_id': classId,
      'image': image,
    };
  }
}
