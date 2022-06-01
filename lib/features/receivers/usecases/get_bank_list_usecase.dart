import 'package:dartz/dartz.dart';
import 'package:uremit/features/receivers/models/get_bank_list_request_model.dart';
import 'package:uremit/features/receivers/models/get_bank_list_response_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/usecase/usecase.dart';

import '../../../services/repository/repository.dart';

class GetBankListUsecase extends UseCase<GetBankListResponseModel, GetBankListRequestModel> {
  Repository repository;

  GetBankListUsecase(this.repository);

  @override
  Future<Either<Failure, GetBankListResponseModel>> call(GetBankListRequestModel params) async {
    return await repository.getBankList(params);
  }
}
