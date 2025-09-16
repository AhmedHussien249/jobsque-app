class EditProfileModel {
  final String bio;
  final String address;
  final String mobile;
  final String language;
  final String interestedWork;
  final String offlinePlace;
  final String remotePlace;
  final String experience;
  final String personalDetailed;
  final String education;

  EditProfileModel({
    required this.bio,
    required this.address,
    required this.mobile,
    required this.language,
    required this.interestedWork,
    required this.offlinePlace,
    required this.remotePlace,
    required this.experience,
    required this.personalDetailed,
    required this.education,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      bio: json['bio'] ?? '',
      address: json['address'] ?? '',
      mobile: json['mobile'] ?? '',
      language: json['language'] ?? '',
      interestedWork: json['interested_work'] ?? '',
      offlinePlace: json['offline_place'] ?? '',
      remotePlace: json['remote_place'] ?? '',
      experience: json['experience'] ?? '',
      personalDetailed: json['personal_detailed'] ?? '',
      education: json['education'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'bio': bio,
        'address': address,
        'mobile': mobile,
        'language': language,
        'interested_work': interestedWork,
        'offline_place': offlinePlace,
        'remote_place': remotePlace,
        'experience': experience,
        'personal_detailed': personalDetailed,
        'education': education,
      };
}
