import 'package:dartz/dartz.dart';
import 'package:uremit/app/models/profile_header_request_model.dart';
import 'package:uremit/app/models/profile_header_response_model.dart';

import '../../services/error/failure.dart';
import '../../services/repository/repository.dart';
import '../../services/usecase/usecase.dart';

class ProfileHeaderUsecase extends UseCase<ProfileHeaderResponseModel, ProfileHeaderRequestModel> {
  Repository repository;
  ProfileHeaderUsecase(this.repository);
  @override
  Future<Either<Failure, ProfileHeaderResponseModel>> call(ProfileHeaderRequestModel params) async {
    return await repository.profileHeader(params);
  }
}
