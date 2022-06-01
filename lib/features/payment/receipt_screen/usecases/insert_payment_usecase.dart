import 'package:dartz/dartz.dart';
import 'package:uremit/features/payment/receipt_screen/modal/insert_payment_response_modal.dart';
import 'package:uremit/features/payment/receipt_screen/modal/insert_payment_transfer_request_model.dart';

import '../../../../services/error/failure.dart';
import '../../../../services/repository/repository.dart';
import '../../../../services/usecase/usecase.dart';

class InsertPaymentUsecase extends UseCase<InsertPaymentTransferResponseModal, InsertPaymentTransferRequestModel> {
  Repository repository;
  InsertPaymentUsecase(this.repository);
  @override
  Future<Either<Failure, InsertPaymentTransferResponseModal>> call(InsertPaymentTransferRequestModel params) async {
    return await repository.insertPaymentTransfer(params);
  }
}