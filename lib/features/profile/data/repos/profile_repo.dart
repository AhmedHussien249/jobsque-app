import 'package:jobsque/features/profile/data/models/edit_profile_model.dart';
import 'package:jobsque/features/profile/data/models/portfolio_model_response.dart';

abstract class ProfileRepo {
  Future<EditProfileModel> editProfile({
    required Map<String, dynamic> queryParams,
  });

  Future<PortfolioResponseModel> getPortfolio();
}
