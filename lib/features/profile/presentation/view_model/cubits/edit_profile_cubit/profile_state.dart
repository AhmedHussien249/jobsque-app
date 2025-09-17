import 'package:jobsque/features/profile/data/models/edit_profile_model.dart';
import 'package:jobsque/features/profile/data/models/portfolio_model_response.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

/// Get Portfolio States
class GetPortfolioLoading extends ProfileState {}

class GetPortfolioSuccess extends ProfileState {
  final PortfolioResponseModel data;
  GetPortfolioSuccess(this.data);
}

class GetPortfolioFailure extends ProfileState {
  final String message;
  GetPortfolioFailure(this.message);
}

/// Edit Profile States
class EditProfileLoading extends ProfileState {}

class EditProfileSuccess extends ProfileState {
  final EditProfileModel data;
  EditProfileSuccess(this.data);
}

class EditProfileFailure extends ProfileState {
  final String message;
  EditProfileFailure(this.message);
}

/// Update Profile Image State
class UpdateProfileImage extends ProfileState {
  final String imagePath;
  UpdateProfileImage(this.imagePath);
}
