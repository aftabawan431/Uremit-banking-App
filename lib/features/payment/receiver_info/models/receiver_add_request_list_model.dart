import 'package:equatable/equatable.dart';

class ReceiverAddRequestListModel extends Equatable {
  const ReceiverAddRequestListModel({
    required this.userID,
    required this.nickName,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.country,
    required this.bank,
    required this.relationShip,
    required this.address,

  });
  final String userID;
  final String nickName;
  final String firstName;
  final String middleName;
  final String lastName;
  final String address;
  final String email;
  final String phone;
  final String relationShip;

  final String country;
  final ReceiverAddRequestListBank bank;

  factory ReceiverAddRequestListModel.fromJson(Map<String, dynamic> json) {
    return ReceiverAddRequestListModel(
      userID: json['userID'],
      nickName: json['nickName'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      relationShip: json['Relationship'],
      email: json['email'],
      address: json['address'],
      phone: json['phone'],
      country: json['country'],
      bank: ReceiverAddRequestListBank.fromJson(json['bank']),
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
    _data['relationship'] = relationShip;

    _data['country'] = country;
    _data['address'] = address;
    _data['bank'] = bank.toJson();
    return _data;
  }

  @override
  List<Object?> get props => [userID, nickName, firstName, middleName, lastName, email, phone, country, bank];
}

class ReceiverAddRequestListBank extends Equatable {
  ReceiverAddRequestListBank({
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

  factory ReceiverAddRequestListBank.fromJson(Map<String, dynamic> json) {
    return ReceiverAddRequestListBank(
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
