import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uremit/features/cards/models/delete_card_request_model.dart';
import 'package:uremit/features/cards/models/get_all_cards_request_model.dart';
import 'package:uremit/features/cards/models/get_all_cards_response_model.dart';
import 'package:uremit/features/cards/usecases/delete_card_usecase.dart';
import 'package:uremit/features/cards/usecases/get_all_cards_usecase.dart';
import 'package:uremit/services/models/on_error_message_model.dart';

import '../../../../app/globals.dart';
import '../../../../app/providers/account_provider.dart';
import '../../../../services/error/failure.dart';
import '../../../../utils/router/app_state.dart';

class CardsViewModel extends ChangeNotifier {
  CardsViewModel({required this.getAllCardsUsecase, required this.deleteCardUsecase});

  // Usecases
  GetAllCardsUsecase getAllCardsUsecase;
  DeleteCardUsecase deleteCardUsecase;

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isDeleteLoadingNotifier = ValueNotifier(false);

  // Properties
  GetAllCardsResponseModel? allCards;


  final TextEditingController cardController = TextEditingController();
  AllCardsBody? selectedCard;
  late String cardId;
  final FocusNode receiverCountryFocusNode = FocusNode();
  // Getters
  AppState appState = GetIt.I.get<AppState>();
  AccountProvider get _accountProvider => sl();

  // Usecase Calls
  Future<void> getAllCards({bool reCall=false}) async {
    if(allCards!=null&&allCards!.allCardsBody.isNotEmpty){
      if(reCall==false){
        return;
      }
    }
    isLoadingNotifier.value = true;

    var getAllCardsEither = await getAllCardsUsecase.call(GetAllCardsRequestModel(_accountProvider.userDetails!.userDetails.id));

    if (getAllCardsEither.isLeft()) {
      handleError(getAllCardsEither);
      allCards = null;
      isLoadingNotifier.value = false;
    } else if (getAllCardsEither.isRight()) {
      getAllCardsEither.foldRight(null, (response, _) {
        allCards = response;
        if(allCards!.allCardsBody.isNotEmpty){
          selectedCard=allCards!.allCardsBody.first;
          cardController.text=selectedCard!.maskedNumber;
        }
      });
      isLoadingNotifier.value = false;
    }
  }
  void emptyList(){
    allCards=null;
    selectedCard=null;
    cardController.clear();
  }

  Future<void> deleteCard({required String id, required BuildContext context}) async {
    isDeleteLoadingNotifier.value = true;

    var deleteCardEither = await deleteCardUsecase.call(DeleteCardRequestModel(id: id));
    isDeleteLoadingNotifier.value = false;

    Navigator.of(context).pop();

    if (deleteCardEither.isLeft()) {
      handleError(deleteCardEither);
    } else if (deleteCardEither.isRight()) {
      deleteCardEither.foldRight(null, (response, _) {
        if (response.deleteCardResponseModelBody == 'True') {
          onErrorMessage?.call(OnErrorMessageModel(message: 'Card deleted successfully', backgroundColor: Colors.green));
        } else {
          onErrorMessage?.call(OnErrorMessageModel(message: 'Something went wrong!'));
        }
      });
      await getAllCards();
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
