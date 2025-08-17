class AppliedJobModel {
  final int id;
  final String name;
  final String email;
  final String mobile;
  final String workType;
  final String? cvFile;
  final String? otherFile;
  final int jobsId;
  final int userId;
  final int reviewed; // API بيرجع 0/1
  final bool? accept; // يمكن null أو true/false
  final String createdAt;
  final String updatedAt;

  AppliedJobModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.workType,
    this.cvFile,
    this.otherFile,
    required this.jobsId,
    required this.userId,
    required this.reviewed,
    this.accept,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppliedJobModel.fromJson(Map<String, dynamic> json) {
    return AppliedJobModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      workType: json['work_type'] ?? '',
      cvFile: json['cv_file'] as String?,
      otherFile: json['other_file'] as String?,
      jobsId: json['jobs_id'] is String ? int.tryParse(json['jobs_id']) ?? 0 : (json['jobs_id'] ?? 0),
      userId: json['user_id'] is String ? int.tryParse(json['user_id']) ?? 0 : (json['user_id'] ?? 0),
      reviewed: json['reviewed'] is int ? json['reviewed'] : (json['reviewed'] == true ? 1 : 0),
      accept: json['accept'] is bool ? json['accept'] : null,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
