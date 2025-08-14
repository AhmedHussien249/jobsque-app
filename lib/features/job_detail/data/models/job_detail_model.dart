class JobDetailModel {
  final int id;
  final String name;
  final String image;
  final String jobTimeType;
  final String jobType;
  final String jobLevel;
  final String jobDescription;
  final String jobSkill;
  final String compName;
  final String compEmail;
  final String compWebsite;
  final String aboutComp;
  final String location;
  final String salary;
  final int favorites;
  final int expired;

  JobDetailModel({
    required this.id,
    required this.name,
    required this.image,
    required this.jobTimeType,
    required this.jobType,
    required this.jobLevel,
    required this.jobDescription,
    required this.jobSkill,
    required this.compName,
    required this.compEmail,
    required this.compWebsite,
    required this.aboutComp,
    required this.location,
    required this.salary,
    required this.favorites,
    required this.expired,
  });

  factory JobDetailModel.fromJson(Map<String, dynamic> json) {
    return JobDetailModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      jobTimeType: json['job_time_type'],
      jobType: json['job_type'],
      jobLevel: json['job_level'],
      jobDescription: json['job_description'],
      jobSkill: json['job_skill'],
      compName: json['comp_name'],
      compEmail: json['comp_email'],
      compWebsite: json['comp_website'],
      aboutComp: json['about_comp'],
      location: json['location'],
      salary: json['salary'],
      favorites: json['favorites'],
      expired: json['expired'],
    );
  }
}
