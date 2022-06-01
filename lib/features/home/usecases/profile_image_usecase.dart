import 'package:dartz/dartz.dart';

import '../../../services/error/failure.dart';
import '../../../services/repository/repository.dart';
import '../../../services/usecase/usecase.dart';
import '../models/profile_image_request_model.dart';
import '../models/profile_image_response_model.dart';

class ProfileImageUsecase extends UseCase<ProfileImageResponseModel, ProfileImageRequestModel> {
  Repository repository;
  ProfileImageUsecase(this.repository);
  @override
  Future<Either<Failure, ProfileImageResponseModel>> call(ProfileImageRequestModel params) async {
    return await repository.profileImage(params);
  }
}
