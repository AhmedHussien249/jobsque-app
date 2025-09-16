import 'package:jobsque/features/profile/data/models/edit_profile_model.dart';
import 'package:jobsque/features/profile/data/models/portfolio_model_response.dart';


abstract class ProfileRepo {
  /// يرسل PUT لتعديل البروفايل.  
  /// queryParams: اللي بتتبعت في الـ URL (زي ?bio=...).
  /// بيرجع EditProfileModel عند النجاح. يلقي ServerFailure عند الفشل.
  Future<EditProfileModel> editProfile({
    required Map<String, dynamic> queryParams,
  });

  /// يجلب البورتفوليو + البروفايل.
  /// بيرجع PortfolioResponseModel عند النجاح. يلقي ServerFailure عند الفشل.
  Future<PortfolioResponseModel> getPortfolio();
}
