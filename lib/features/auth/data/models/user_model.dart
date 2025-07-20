class UserModel {
  final int id;
  final String name;
  final String email;
  final String token;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    return UserModel(
      id: user['id'],
      name: user['name'],
      email: user['email'],
      createdAt: DateTime.parse(user['created_at']),
      updatedAt: DateTime.parse(user['updated_at']),
      token: json['token'],
    );
  }
}
