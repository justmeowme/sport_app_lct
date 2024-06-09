class User {
  final int id;
  final String? login;
  final String? password;
  final String? gender;
  final int height;
  final int weight;
  final String? goals;
  final String? experience;
  final bool gymMember;
  final bool beginner;
  final String? gymName;
  final String? healthConditions;
  final int role;

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
      id: json['Id'],
      login: json['Login'],
      password: json['Password'],
      gender: json['Gender'] ?? '',
      height: json['Height'] ?? 0,
      weight: json['Weight'] ?? 0,
      goals: json['Goals'] ?? '',
      experience: json['Experience'] ?? '',
      gymMember: json['GymMember'] ?? false,
      beginner: json['Beginner'] ?? false,
      gymName: json['GymName'] ?? '',
      healthConditions: json['HealthConditions'] ?? '',
      role: json['Role'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Login': login,
      'Password': password,
      'Gender': gender,
      'Height': height,
      'Weight': weight,
      'Goals': goals,
      'Experience': experience,
      'GymMember': gymMember,
      'Beginner': beginner,
      'GymName': gymName,
      'HealthConditions': healthConditions,
      'Role': role,
    };
  }
}
