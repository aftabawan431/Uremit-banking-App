import 'package:dartz/dartz.dart';
import 'package:uremit/features/payment/payment_details/models/update_transaction_status_request_model.dart';
import 'package:uremit/features/payment/payment_details/models/update_transaction_status_response_model.dart';

import '../../../../services/error/failure.dart';
import '../../../../services/repository/repository.dart';
import '../../../../services/usecase/usecase.dart';

class UpdateTransactionStatusUsecase extends UseCase<UpdateTransactionStatusResponseModel, UpdateTransactionStatusRequestModel> {
  Repository repository;
  UpdateTransactionStatusUsecase(this.repository);
  @override
  Future<Either<Failure, UpdateTransactionStatusResponseModel>> call(UpdateTransactionStatusRequestModel params) async {
    return await repository.updateTransactionStatus(params);
  }
}
