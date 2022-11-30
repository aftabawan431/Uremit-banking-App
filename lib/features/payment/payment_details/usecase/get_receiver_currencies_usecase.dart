import 'package:dartz/dartz.dart';
import 'package:uremit/features/payment/payment_details/models/get_receiver_currencies_request_model.dart';
import 'package:uremit/features/payment/payment_details/models/get_receiver_currencies_response_model.dart';
import 'package:uremit/features/payment/payment_details/models/update_transaction_status_request_model.dart';
import 'package:uremit/features/payment/payment_details/models/update_transaction_status_response_model.dart';

import '../../../../services/error/failure.dart';
import '../../../../services/repository/repository.dart';
import '../../../../services/usecase/usecase.dart';

class GetReceiverCurrenciesUsecase extends UseCase<GetReceiverCurrenciesResponseModel, GetReceiverCurrenciesRequestModel> {
  Repository repository;
  GetReceiverCurrenciesUsecase(this.repository);
  @override
  Future<Either<Failure, GetReceiverCurrenciesResponseModel>> call(GetReceiverCurrenciesRequestModel params) async {
    return await repository.getReceiverCurrencies(params);
  }
}
