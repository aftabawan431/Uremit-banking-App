import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:uremit/features/dashboard/models/get_promotion_list_request_model.dart';
import 'package:uremit/features/dashboard/models/get_promotion_list_response_model.dart';
import 'package:uremit/features/dashboard/models/get_transaction_list_request_model.dart';
import 'package:uremit/features/dashboard/models/get_transaction_list_response_model.dart';
import 'package:uremit/features/dashboard/usecases/get_promotion_list_usecase.dart';
import 'package:uremit/features/dashboard/usecases/get_transaction_list_usecase.dart';
import 'package:uremit/services/models/on_error_message_model.dart';

import '../../../../app/globals.dart';
import '../../../../app/providers/account_provider.dart';
import '../../../../services/error/failure.dart';
import '../../../../utils/router/app_state.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel({required this.getPromotionListUsecase, required this.getTransactionListUsecase});

  // Usecases
  GetPromotionListUsecase getPromotionListUsecase;
  GetTransactionListUsecase getTransactionListUsecase;

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isPromotionLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isTransactionListLoadingNotifier = ValueNotifier(false);
  ValueNotifier<String> statusSearchNotifier = ValueNotifier('All');
  ValueNotifier<List<TransactionList>> transactionList = ValueNotifier([]);

  // Properties
  GetPromotionListResponseModel? promotionList;

  GetTransactionListResponseModel? getTransactionLists;

  // Getters
  AppState appState = GetIt.I.get<AppState>();
  AccountProvider get _accountProvider => sl();

  // Usecase Calls
  Future<void> getPromotionList() async {
    isPromotionLoadingNotifier.value = true;

    var promotionEither = await getPromotionListUsecase.call(GetPromotionListRequestModel(id: _accountProvider.userDetails!.userDetails.id));

    if (promotionEither.isLeft()) {
      handleError(promotionEither);
      isPromotionLoadingNotifier.value = false;
    } else if (promotionEither.isRight()) {
      promotionEither.foldRight(null, (response, _) {
        promotionList = response;
      });
      isPromotionLoadingNotifier.value = false;
    }
  }

  Future<void> getTransactionList() async {
    isTransactionListLoadingNotifier.value = true;
    var transactionListEither = await getTransactionListUsecase.call(GetTransactionListRequestModel(
      userId: _accountProvider.userDetails!.userDetails.id.toString(),
      statusDescription: 'AllTransactions'.toString(),
    ));

    if (transactionListEither.isLeft()) {
      handleError(transactionListEither);
      isTransactionListLoadingNotifier.value = false;
    } else if (transactionListEither.isRight()) {
      transactionListEither.foldRight(null, (response, _) {
        transactionList.value = response.getTransactionListResponseModelBody.transactionList;

        getTransactionLists = response;
      });
      isTransactionListLoadingNotifier.value = false;
    }
  }

  void onSearchTransactionChange(String? value) {
    if (statusSearchNotifier.value == 'All') {
      transactionList.value =
          getTransactionLists!.getTransactionListResponseModelBody.transactionList.where((element) => element.receiverName.toLowerCase().contains(value!.toLowerCase())).toList();
    } else if (statusSearchNotifier.value == 'Pending') {
      transactionList.value = getTransactionLists!.getTransactionListResponseModelBody.transactionList
          .where((element) => element.receiverName.toLowerCase().contains(value!.toLowerCase()) && element.status == 'Requested')
          .toList();
    } else if (statusSearchNotifier.value == 'Successful') {
      transactionList.value = getTransactionLists!.getTransactionListResponseModelBody.transactionList
          .where((element) => element.receiverName.toLowerCase().contains(value!.toLowerCase()) && element.status == 'Completed')
          .toList();
    }
  }

  onStatusChange(String? value) {
    if (value == 'all') {
      transactionList.value = getTransactionLists!.getTransactionListResponseModelBody.transactionList;
    } else {
      transactionList.value = getTransactionLists!.getTransactionListResponseModelBody.transactionList.where((element) => element.status == value).toList();
    }
  }

  // Methods

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    isLoadingNotifier.value = false;
    either.fold((l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)), (r) => null);
  }

// Page Moves
}
