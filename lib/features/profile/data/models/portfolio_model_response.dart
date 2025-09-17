import 'profile_model.dart';

class PortfolioResponseModel {
  final List<dynamic> portofolio;
  final ProfileModel? profile;

  PortfolioResponseModel({required this.portofolio, required this.profile});

  factory PortfolioResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    final port = data['portofolio'] as List<dynamic>? ?? [];
    final prof = data['profile'] as Map<String, dynamic>?;
    return PortfolioResponseModel(
      portofolio: port,
      profile: prof != null ? ProfileModel.fromJson(prof) : null,
    );
  }
}
