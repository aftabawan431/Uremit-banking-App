import 'package:dartz/dartz.dart';

import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/usecase/usecase.dart';

import '../../../services/repository/repository.dart';
import '../models/add_receiver_bank_request_model.dart';
import '../models/add_receiver_bank_response_model.dart';

class AddReceiverBankListUsecase extends UseCase<AddReceiverBankResponseModel, AddReceiverBankRequestModel> {
  Repository repository;

  AddReceiverBankListUsecase(this.repository);

  @override
  Future<Either<Failure, AddReceiverBankResponseModel>> call(AddReceiverBankRequestModel params) async {
    return await repository.addReceiverBank(params);
  }
}
