class JobModel {
  final int id;
  final String name;
  final String compName;
  final String location;
  final String jobType;
  final String jobTimeType;
  final String salary;
  final String image;

  JobModel({
    required this.id,
    required this.name,
    required this.compName,
    required this.location,
    required this.jobType,
    required this.jobTimeType,
    required this.salary,
    required this.image,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'],
      name: json['name'],
      compName: json['comp_name'],
      location: json['location'],
      jobType: json['job_type'],
      jobTimeType: json['job_time_type'],
      salary: json['salary'],
      image: json['image'],
    );
  }
}
