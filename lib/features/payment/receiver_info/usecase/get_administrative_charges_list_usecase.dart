import 'package:dartz/dartz.dart';
import 'package:uremit/features/payment/receiver_info/models/get_administrative_charges_list_response_model.dart';
import 'package:uremit/features/payment/receiver_info/models/get_admistrative_charges_list_request_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/usecase/usecase.dart';

import '../../../../services/repository/repository.dart';

class GetAdministrativeChargesListUsecase extends UseCase<GetAdministrativeChargesListResponseModel,GetAdministrativeChargesListRequestModel> {
  Repository repository;

  GetAdministrativeChargesListUsecase(this.repository);

  @override
  Future<Either<Failure, GetAdministrativeChargesListResponseModel>> call(GetAdministrativeChargesListRequestModel params) async {
    return await repository.getAdministrativeChargesLists(params);
  }
}
