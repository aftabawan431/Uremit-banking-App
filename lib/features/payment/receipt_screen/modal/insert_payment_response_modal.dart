import 'package:equatable/equatable.dart';
import 'package:uremit/features/payment/receipt_screen/modal/paid_response_modal.dart';
import 'package:uremit/features/payment/receipt_screen/modal/poly_response_modal.dart';
import 'package:uremit/features/payment/receipt_screen/modal/transection_three_sixty_respose_modal.dart';

class InsertPaymentTransferResponseModal extends Equatable {
  InsertPaymentTransferResponseModal({
     this.threeSixtyResponseModal,
     this.payIdBankResponseModal,
     this.polyResponseModal,
    this.manualBankResponseModal
  });

   PolyResponseModal? polyResponseModal;
   PayIdBankResponseModal? payIdBankResponseModal;
   ManualBankResponseModal? manualBankResponseModal;
   TransectionThreeSixtyResponseModal? threeSixtyResponseModal;

  factory InsertPaymentTransferResponseModal.fromJson(
      Map<String, dynamic> json) {
    return InsertPaymentTransferResponseModal(
        polyResponseModal: json['polyResponseModal'],
        payIdBankResponseModal: json['payIdResponseModal'] ,
        threeSixtyResponseModal: json['threeSixtyResponseModal'],
      manualBankResponseModal: json['manualBankResponseModal']
       );
  }

  // Map<String, dynamic> toJson() {
  //   final _data = <String, dynamic>{};
  //   _data['statusCode'] = statusCode;
  //   _data['statusMessage'] = statusMessage;
  //   _data['traceId'] = traceId;
  //   _data['body'] = body.to;
  //   return _data;
  // }

  @override
  // TODO: implement props
  List<Object?> get props => [polyResponseModal, payIdBankResponseModal, threeSixtyResponseModal,manualBankResponseModal];
}

class Body extends Equatable {
  Body(
      {required this.success,
      required this.errorCode,
      required this.errorMessage,
      required this.navigateUrl,
      required this.transactionRefNo});
  final bool success;
  final String navigateUrl;
  final int errorCode;
  final String errorMessage;
  final String transactionRefNo;

  factory Body.fromJson(Map<String, dynamic> json) {
    return Body(
        success: json['success'],
        errorCode: json['errorCode']??0,
        errorMessage: json['errorMessage']??'',
        navigateUrl: json['errorMessage']??'',
        transactionRefNo: json['errorMessge']??'');
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [success, errorMessage, errorCode, navigateUrl, transactionRefNo];
}

class Checkout extends Equatable {
  Checkout({
    required this.token,
    required this.redirectUrl,
  });
  final String token;
  final String redirectUrl;

  factory Checkout.fromJson(Map<String, dynamic> json) {
    return Checkout(token: json['token'], redirectUrl: json['redirectUrl']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    _data['redirect_url'] = redirectUrl;
    return _data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [token, redirectUrl];
}
