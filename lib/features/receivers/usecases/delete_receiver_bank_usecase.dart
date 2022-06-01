import 'package:dartz/dartz.dart';
import 'package:uremit/features/receivers/models/delete_receiver_bank_request_model.dart';
import 'package:uremit/features/receivers/models/delete_receiver_bank_response_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/usecase/usecase.dart';

import '../../../services/repository/repository.dart';


class DeleteReceiverBankListUsecase extends UseCase<DeleteReceiverBankListResponseModel, DeleteReceiverBankListRequestModel> {
  Repository repository;

  DeleteReceiverBankListUsecase(this.repository);

  @override
  Future<Either<Failure, DeleteReceiverBankListResponseModel>> call(DeleteReceiverBankListRequestModel params) async {
    return await repository.deleteReceiverBank(params);
  }
}
