import 'package:dartz/dartz.dart';
import 'package:uremit/features/payment/receiver_info/models/get_uremit_banks_countires_response_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/usecase/usecase.dart';

import '../../../../services/models/no_params.dart';
import '../../../../services/repository/repository.dart';

class GetUremitBanksCountriesUsecase extends UseCase<GetUremitBanksCountriesResponseModel, NoParams> {
  Repository repository;

  GetUremitBanksCountriesUsecase(this.repository);

  @override
  Future<Either<Failure, GetUremitBanksCountriesResponseModel>> call(NoParams params) async {
    return await repository.getUremitBanksCountries(params);
  }
}
