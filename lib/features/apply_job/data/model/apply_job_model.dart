class ApplyJobModel {
  final bool status;
  final ApplyJobData? data;

  ApplyJobModel({required this.status, this.data});

  factory ApplyJobModel.fromJson(Map<String, dynamic> json) {
    return ApplyJobModel(
      status: json['status'],
      data: json['data'] != null ? ApplyJobData.fromJson(json['data']) : null,
    );
  }
}

class ApplyJobData {
  final String cvFile;
  final String name;
  final String email;
  final String mobile;
  final String workType;
  final String otherFile;
  final String jobsId;
  final String userId;
  final bool reviewed;
  final String createdAt;
  final String updatedAt;
  final int id;

  ApplyJobData({
    required this.cvFile,
    required this.name,
    required this.email,
    required this.mobile,
    required this.workType,
    required this.otherFile,
    required this.jobsId,
    required this.userId,
    required this.reviewed,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  factory ApplyJobData.fromJson(Map<String, dynamic> json) {
    return ApplyJobData(
      cvFile: json['cv_file'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      workType: json['work_type'],
      otherFile: json['other_file'],
      jobsId: json['jobs_id'],
      userId: json['user_id'],
      reviewed: json['reviewed'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      id: json['id'],
    );
  }
}
