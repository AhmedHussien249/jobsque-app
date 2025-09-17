class ProfileModel {
  final int id;
  final int userId;
  final String name;
  final String email;
  final String mobile;
  final String address;
  final String language;
  final String interestedWork;
  final String offlinePlace;
  final String remotePlace;
  final String bio;
  final String education;
  final String experience;
  final String personalDetailed;
  final String createdAt;
  final String updatedAt;

  ProfileModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.mobile,
    required this.address,
    required this.language,
    required this.interestedWork,
    required this.offlinePlace,
    required this.remotePlace,
    required this.bio,
    required this.education,
    required this.experience,
    required this.personalDetailed,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse('${json['id'] ?? 0}') ?? 0,
      userId: json['user_id'] is int
          ? json['user_id']
          : int.tryParse('${json['user_id'] ?? 0}') ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      address: json['address'] ?? '',
      language: json['language'] ?? '',
      interestedWork: json['interested_work'] ?? '',
      offlinePlace: json['offline_place'] ?? '',
      remotePlace: json['remote_place'] ?? '',
      bio: json['bio'] ?? '',
      education: json['education'] ?? '',
      experience: json['experience'] ?? '',
      personalDetailed: json['personal_detailed'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'name': name,
    'email': email,
    'mobile': mobile,
    'address': address,
    'language': language,
    'interested_work': interestedWork,
    'offline_place': offlinePlace,
    'remote_place': remotePlace,
    'bio': bio,
    'education': education,
    'experience': experience,
    'personal_detailed': personalDetailed,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
