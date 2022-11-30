import 'package:dartz/dartz.dart';
import 'package:uremit/features/payment/payment_details/models/get_rate_lists_response_model.dart';
import 'package:uremit/features/payment/receipt_screen/modal/get_Payment_Method_Response_Model.dart';
import 'package:uremit/features/payment/receipt_screen/modal/get_payment_methods_request_model.dart';

import '../../../../services/error/failure.dart';
import '../../../../services/models/no_params.dart';
import '../../../../services/repository/repository.dart';
import '../../../../services/usecase/usecase.dart';
import '../../../menu/update_profile/models/get_countries_response_model.dart';

class GetPaymentMethodsReponseUsecase extends UseCase<GetPaymentMethodResponseModal, GetPaymentMethodsRequestModel> {
  Repository repository;

  GetPaymentMethodsReponseUsecase(this.repository);

  @override
  Future<Either<Failure, GetPaymentMethodResponseModal>> call(GetPaymentMethodsRequestModel params) async {
    return await repository.getPaymentMethods(params);
  }
}