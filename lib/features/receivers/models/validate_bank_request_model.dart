import 'package:equatable/equatable.dart';

class ValidateBankRequestModel extends Equatable {
  const ValidateBankRequestModel({
    required this.accountNumber,
    required this.bankId,
  });

  final String accountNumber;
  final String bankId;

  factory ValidateBankRequestModel.fromJson(Map<String, dynamic> json) {
    return ValidateBankRequestModel(
      accountNumber: json['accountNumber'],
      bankId: json['bankId'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['accountNumber'] = accountNumber;
    _data['bankId'] = bankId;
    return _data;
  }

  @override
  List<Object?> get props => [
        accountNumber,
        bankId,
      ];
}
