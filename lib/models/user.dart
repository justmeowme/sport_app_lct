class User {
  final int? id;
  final String? login;
  final String? password;
  final String? gender;
  final int? height;
  final int? weight;
  final String? goals;
  final String? experience;
  final bool? gymMember;
  final bool? beginner;
  final String? gymName;
  final String? healthConditions;
  final int? role;

  User({
    required this.id,
    required this.login,
    required this.password,
    this.gender = '',
    this.height = 0,
    this.weight = 0,
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
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      goals: json['goals'] ?? '',
      experience: json['experience'] ?? '',
      gymMember: json['gymMember'] ?? false,
      beginner: json['beginner'] ?? false,
      gymName: json['gymName'] ?? '',
      healthConditions: json['healthConditions'] ?? '',
      role: json['role'] ?? 0,
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
    };
  }

  User copyWith({
    int? id,
    String? login,
    String? password,
    String? gender,
    int? height,
    int? weight,
    String? goals,
    String? experience,
    bool? gymMember,
    bool? beginner,
    String? gymName,
    String? healthConditions,
    int? role,
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
    );
  }
}
