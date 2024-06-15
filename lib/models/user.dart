class User {
  final int? id;
  final String? name;
  final String login;
  final String? password;
  final String? gender;
  final List<dynamic>? height;
  final List<dynamic>? weight;
  final String? goals;
  final String? experience;
  final bool? gymMember;
  final bool? beginner;
  final String? gymName;
  final String? healthConditions;
  final int? role;
  final String? about;
  final String? achivements;
  final List<dynamic>? water;
  final List<dynamic>? trains;

  User({
    this.about,
    this.achivements,
    this.water,
    this.trains,
    required this.id,
    required this.login,
    required this.password,
    this.name = "Без Имени",
    this.gender = '',
    this.height,
    this.weight,
    this.goals = '',
    this.experience = '',
    this.gymMember = false,
    this.beginner = false,
    this.gymName = '',
    this.healthConditions = '',
    this.role = 0,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      login: json['login'],
      password: json['password'],
      gender: json['gender'] ?? '',
      height: json['height'] ?? [],
      weight: json['weight'] ?? [],
      goals: json['goals'] ?? '',
      experience: json['experience'] ?? '',
      gymMember: json['gymMember'] ?? false,
      beginner: json['beginner'] ?? false,
      gymName: json['gymName'] ?? '',
      healthConditions: json['healthConditions'] ?? '',
      role: json['role'] ?? 0,
      water: json['water'] ?? [],
      trains: json['trains'] ?? []
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'password': password,
      'gender': gender,
      'height': height,
      'weight': weight,
      'goals': goals,
      'experience': experience,
      'gymMember': gymMember,
      'beginner': beginner,
      'gymName': gymName,
      'healthConditions': healthConditions,
      'role': role,
      'trains': trains,
      'water': water,
    };
  }

  User copyWith({
    int? id,
    String? login,
    String? password,
    String? gender,
    List<dynamic>? height,
    List<dynamic>? weight,
    String? goals,
    String? experience,
    bool? gymMember,
    bool? beginner,
    String? gymName,
    String? healthConditions,
    int? role,
    List<dynamic>? water,
    List<dynamic>? trains,

  }) {
    return User(
      id: id ?? this.id,
      login: login ?? this.login,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      goals: goals ?? this.goals,
      experience: experience ?? this.experience,
      gymMember: gymMember ?? this.gymMember,
      beginner: beginner ?? this.beginner,
      gymName: gymName ?? this.gymName,
      healthConditions: healthConditions ?? this.healthConditions,
      role: role ?? this.role,
      water: water ?? this.water,
      trains: trains ?? this.trains,
    );
  }
}
