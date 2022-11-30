import 'package:dartz/dartz.dart';
import 'package:uremit/features/payment/receipt_screen/modal/get_transaction_by%20_txn_response_model.dart';
import 'package:uremit/features/payment/receipt_screen/modal/get_transaction_by_txn_request_model.dart';
import 'package:uremit/features/payment/receipt_screen/modal/insert_payment_response_modal.dart';
import 'package:uremit/features/payment/receipt_screen/modal/insert_payment_transfer_request_model.dart';

import '../../../../services/error/failure.dart';
import '../../../../services/repository/repository.dart';
import '../../../../services/usecase/usecase.dart';

class GetTransactionByTxnUsecase extends UseCase<GetTransactionByTxnResponseModel, GetTransactionByTxnRequestModel> {
  Repository repository;
  GetTransactionByTxnUsecase(this.repository);
  @override
  Future<Either<Failure, GetTransactionByTxnResponseModel>> call(GetTransactionByTxnRequestModel params) async {
    return await repository.getTransactionByTxn(params);
  }
}