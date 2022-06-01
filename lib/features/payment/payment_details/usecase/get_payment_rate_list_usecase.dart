import 'package:dartz/dartz.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/usecase/usecase.dart';

import '../../../../services/models/no_params.dart';
import '../../../../services/repository/repository.dart';
import '../models/get_rate_lists_response_model.dart';

class GetPaymentRateListUsecase extends UseCase<GetPaymentRateListResponseModal, NoParams> {
  Repository repository;

  GetPaymentRateListUsecase(this.repository);

  @override
  Future<Either<Failure, GetPaymentRateListResponseModal>> call(NoParams params) async {
    return await repository.getRateLists(params);
  }
}
