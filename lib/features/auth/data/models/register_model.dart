class RegisterModel {
  final RegisterData data;
  final Profile profile;
  final String token;

  RegisterModel({
    required this.data,
    required this.profile,
    required this.token,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      data: RegisterData.fromJson(json['data']),
      profile: Profile.fromJson(json['profile']),
      token: json['token'],
    );
  }
}

class RegisterData {
  final int id;
  final String name;
  final String email;
  final int otp;
  final String createdAt;
  final String updatedAt;

  RegisterData({
    required this.id,
    required this.name,
    required this.email,
    required this.otp,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      otp: json['otp'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Profile {
  final int id;
  final int userId;
  final String name;
  final String email;
  final String createdAt;
  final String updatedAt;

  Profile({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
