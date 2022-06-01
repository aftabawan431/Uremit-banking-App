import 'package:dartz/dartz.dart';
import 'package:uremit/features/authentication/rates/models/get_rate_list_response_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/usecase/usecase.dart';

import '../../../../services/models/no_params.dart';
import '../../../../services/repository/repository.dart';

class GetRateListUsecase extends UseCase<GetRateListResponseModel, NoParams> {
  Repository repository;

  GetRateListUsecase(this.repository);

  @override
  Future<Either<Failure, GetRateListResponseModel>> call(NoParams params) async {
    return await repository.getShortRateList(params);
  }
}
