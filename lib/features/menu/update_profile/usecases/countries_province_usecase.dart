import 'package:dartz/dartz.dart';
import 'package:uremit/features/menu/update_profile/models/countries_province_request_model.dart';
import 'package:uremit/features/menu/update_profile/models/countries_province_response_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/usecase/usecase.dart';

import '../../../../services/repository/repository.dart';

class CountriesProvinceUsecase extends UseCase<CountriesProvinceResponseModel, CountriesProvinceRequestModel> {
  Repository repository;

  CountriesProvinceUsecase(this.repository);

  @override
  Future<Either<Failure, CountriesProvinceResponseModel>> call(CountriesProvinceRequestModel params) async {
    return await repository.getCountryProvinces(params);
  }
}
