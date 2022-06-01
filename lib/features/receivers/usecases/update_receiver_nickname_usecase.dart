import 'package:dartz/dartz.dart';
import 'package:uremit/features/receivers/models/update_receiver_nickname_request_model.dart';
import 'package:uremit/features/receivers/models/update_receiver_nickname_response_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/usecase/usecase.dart';

import '../../../services/repository/repository.dart';


class UpdateReceiverNicknameUsecase extends UseCase<UpdateReceiverNicknameResponseModel, UpdateReceiverNicknameRequestModel> {
  Repository repository;

  UpdateReceiverNicknameUsecase(this.repository);

  @override
  Future<Either<Failure, UpdateReceiverNicknameResponseModel>> call(UpdateReceiverNicknameRequestModel params) async {
    return await repository.updateReceiverNickname(params);
  }
}