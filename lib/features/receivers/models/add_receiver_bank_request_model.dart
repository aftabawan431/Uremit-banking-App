import 'package:equatable/equatable.dart';

class AddReceiverBankRequestModel extends Equatable {
  const AddReceiverBankRequestModel({
    required this.receiverID,
    required this.userID,
    required this.bankCode,
    required this.accountTitle,
    required this.accountNo,
    required this.branchCode,
    required this.isIban,
  });
  final String receiverID;
  final String userID;
  final String bankCode;
  final String accountTitle;
  final String accountNo;
  final String branchCode;
  final int isIban;

  factory AddReceiverBankRequestModel.fromJson(Map<String, dynamic> json) {
    return AddReceiverBankRequestModel(
      receiverID: json['receiverID'],
      userID: json['userID'],
      bankCode: json['bankCode'],
      accountTitle: json['accountTitle'],
      accountNo: json['accountNo'],
      branchCode: json['branchCode'],
      isIban: json['isIban'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['receiverID'] = receiverID;
    _data['userID'] = userID;
    _data['bankCode'] = bankCode;
    _data['accountTitle'] = accountTitle;
    _data['accountNo'] = accountNo;
    _data['branchCode'] = branchCode;
    _data['isIban'] = isIban;
    return _data;
  }

  @override
  List<Object?> get props => [receiverID, userID, bankCode, accountTitle, accountNo, branchCode, isIban];
}
