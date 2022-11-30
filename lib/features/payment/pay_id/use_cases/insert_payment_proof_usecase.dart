import 'package:dartz/dartz.dart';
import 'package:uremit/features/payment/pay_id/modal/insert_payment_proof_response_modal.dart';
import 'package:uremit/features/payment/pay_id/modal/insert_payment_response_request_modal.dart';
import '../../../../services/error/failure.dart';
import '../../../../services/repository/repository.dart';
import '../../../../services/usecase/usecase.dart';

class InsertPaymentProofUsecase extends UseCase<InsertPaymentProofResponseModal,
    InsertPaymentProofRequestModal> {
  Repository repository;

  InsertPaymentProofUsecase(this.repository);

  @override
  Future<Either<Failure, InsertPaymentProofResponseModal>> call(
      InsertPaymentProofRequestModal params) async {
    return await repository.insertPaymentProof(params);
  }
}
