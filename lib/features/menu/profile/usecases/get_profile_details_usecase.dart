import 'package:dartz/dartz.dart';
import 'package:uremit/features/menu/profile/models/get_profile_details_request_model.dart';
import 'package:uremit/features/menu/profile/models/get_profile_details_response_model.dart';

import '../../../../services/error/failure.dart';
import '../../../../services/repository/repository.dart';
import '../../../../services/usecase/usecase.dart';

class GetProfileDetailsUsecase extends UseCase<GetProfileDetailsResponseModel, GetProfileDetailsRequestModel> {
  Repository repository;
  GetProfileDetailsUsecase(this.repository);
  @override
  Future<Either<Failure, GetProfileDetailsResponseModel>> call(GetProfileDetailsRequestModel params) async {
    return await repository.getProfileDetails(params);
  }
}
