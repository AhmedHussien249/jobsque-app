import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/core/errors/failure.dart';
import 'package:jobsque/core/storage/app_preferences.dart';
import 'package:jobsque/core/utils/service_locator.dart';
import 'package:jobsque/features/profile/data/repos/profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo repo;
  ProfileCubit(this.repo) : super(ProfileInitial()){
    loadInitialProfileImage();
  }

  /// جلب البورتفوليو + البروفايل
  Future<void> getPortfolio() async {
    emit(GetPortfolioLoading());
    try {
      final result = await repo.getPortfolio();
      emit(GetPortfolioSuccess(result));
    } on ServerFailure catch (f) {
      emit(GetPortfolioFailure(f.errorMessage));
    } catch (e) {
      emit(GetPortfolioFailure(e.toString()));
    }
  }

  /// تعديل البروفايل: هنستقبل queryParams كـ Map عشان تتمكن من تمرير كل الحقول من الفورم بسهولة
  Future<void> editProfile({required Map<String, dynamic> queryParams}) async {
    emit(EditProfileLoading());
    try {
      final result = await repo.editProfile(queryParams: queryParams);
      emit(EditProfileSuccess(result));
    } on ServerFailure catch (f) {
      emit(EditProfileFailure(f.errorMessage));
    } catch (e) {
      emit(EditProfileFailure(e.toString()));
    }
  }
  /// تحديث صورة البروفايل فورًا
Future<void> loadInitialProfileImage() async {
    final path = sl<AppPreferences>().getProfileImage();
    if (path != null && path.isNotEmpty) {
      emit(UpdateProfileImage(path));
    }
  }
  Future<void> updateProfileImage(String path) async {
    
    await sl<AppPreferences>().setProfileImage(path);
    emit(UpdateProfileImage(path));
  }

}
