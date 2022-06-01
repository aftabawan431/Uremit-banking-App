import 'package:dartz/dartz.dart';

import '../../../../services/error/failure.dart';
import '../../../../services/repository/repository.dart';
import '../../../../services/usecase/usecase.dart';
import '../../../menu/profile/models/get_profile_details_response_model.dart';
import '../models/set_profile_details_request_model.dart';

//!! this usecase can also be use for the paymentPersonal details screen where
// user can set his details first time and then for update same usecase will be used.
class SetProfileDetailsUsecase extends UseCase<GetProfileDetailsResponseModel, SetProfileDetailsRequestModel> {
  Repository repository;
  SetProfileDetailsUsecase(this.repository);
  @override
  Future<Either<Failure, GetProfileDetailsResponseModel>> call(SetProfileDetailsRequestModel params) async {
    return await repository.setProfileDetails(params);
  }
}
