import 'package:dartz/dartz.dart';
import 'package:uremit/features/home/models/get_profile_admin_approval_response_model.dart';
import 'package:uremit/features/menu/profile/models/get_profile_details_response_model.dart';

import '../../../services/error/failure.dart';
import '../../../services/repository/repository.dart';
import '../../../services/usecase/usecase.dart';
import '../models/get_profile_admin_approvel_request_model.dart';
import '../models/profile_image_request_model.dart';
import '../models/profile_image_response_model.dart';

class GetProfileAdminApprovelUsecase extends UseCase<GetProfileAdminApprovelResponseModel, GetProfileAdminApprovelRequestModel> {
  Repository repository;
  GetProfileAdminApprovelUsecase(this.repository);
  @override
  Future<Either<Failure, GetProfileAdminApprovelResponseModel>> call(GetProfileAdminApprovelRequestModel params) async {
    return await repository.profileAdminApprovel(params);
  }
}
