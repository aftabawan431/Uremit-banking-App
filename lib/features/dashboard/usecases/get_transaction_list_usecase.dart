import 'package:dartz/dartz.dart';
import 'package:uremit/features/dashboard/models/get_transaction_list_request_model.dart';
import 'package:uremit/features/dashboard/models/get_transaction_list_response_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/repository/repository.dart';
import 'package:uremit/services/usecase/usecase.dart';

class GetTransactionListUsecase extends UseCase<GetTransactionListResponseModel, GetTransactionListRequestModel> {
  Repository repository;

  GetTransactionListUsecase(this.repository);

  @override
  Future<Either<Failure, GetTransactionListResponseModel>> call(GetTransactionListRequestModel params) async {
    return await repository.getTransactionList(params);
  }
}
