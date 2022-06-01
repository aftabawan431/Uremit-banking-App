import 'package:equatable/equatable.dart';

class AddReceiverRequestModel extends Equatable {
  const AddReceiverRequestModel({
    required this.userID,
    required this.nickName,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.countryID,
    required this.country,
    required this.bank,
  });
  final String userID;
  final String nickName;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String phone;
  final String countryID;
  final String country;
  final AddReceiverRequestModelBank bank;

  factory AddReceiverRequestModel.fromJson(Map<String, dynamic> json) {
    return AddReceiverRequestModel(
      userID: json['userID'],
      nickName: json['nickName'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      countryID: json['countryID'],
      country: json['country'],
      bank: AddReceiverRequestModelBank.fromJson(json['bank']),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userID'] = userID;
    _data['nickName'] = nickName;
    _data['firstName'] = firstName;
    _data['middleName'] = middleName;
    _data['lastName'] = lastName;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['countryID'] = countryID;
    _data['country'] = country;
    _data['bank'] = bank.toJson();
    return _data;
  }

  @override
  List<Object?> get props => [
        userID,
        nickName,
        firstName,
        middleName,
        lastName,
        email,
        phone,
        countryID,
        country,
        bank,
      ];
}

class AddReceiverRequestModelBank extends Equatable {
  const AddReceiverRequestModelBank({
    required this.bankCode,
    required this.accountTitle,
    required this.accountNo,
    required this.branchCode,
    required this.isIban,
  });
  final String bankCode;
  final String accountTitle;
  final String accountNo;
  final String branchCode;
  final int isIban;

  factory AddReceiverRequestModelBank.fromJson(Map<String, dynamic> json) {
    return AddReceiverRequestModelBank(
      bankCode: json['bankCode'],
      accountTitle: json['accountTitle'],
      accountNo: json['accountNo'],
      branchCode: json['branchCode'],
      isIban: json['isIban'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bankCode'] = bankCode;
    _data['accountTitle'] = accountTitle;
    _data['accountNo'] = accountNo;
    _data['branchCode'] = branchCode;
    _data['isIban'] = isIban;
    return _data;
  }

  @override
  List<Object?> get props => [
        bankCode,
        accountTitle,
        accountNo,
        branchCode,
        isIban,
      ];
}
