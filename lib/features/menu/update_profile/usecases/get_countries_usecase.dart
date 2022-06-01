import 'package:dartz/dartz.dart';
import 'package:uremit/features/menu/update_profile/models/get_countries_response_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/usecase/usecase.dart';

import '../../../../services/models/no_params.dart';
import '../../../../services/repository/repository.dart';

class GetCountriesUsecase extends UseCase<GetCountriesResponseModel, NoParams> {
  Repository repository;

  GetCountriesUsecase(this.repository);

  @override
  Future<Either<Failure, GetCountriesResponseModel>> call(NoParams params) async {
    return await repository.getCountries(params);
  }
}
