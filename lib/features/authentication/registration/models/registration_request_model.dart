import 'package:equatable/equatable.dart';

class RegistrationRequestModel extends Equatable {
  const RegistrationRequestModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.countryId,
    required this.companyId,
    required this.isSubscribed,
    required this.referralCode,
    required this.phoneNumber,
  });

  final String email;
  final String password;
  final String confirmPassword;
  final int countryId;
  final int companyId;
  final bool isSubscribed;
  final String referralCode;
  final String phoneNumber;

  factory RegistrationRequestModel.fromJson(Map<String, dynamic> json) {
    return RegistrationRequestModel(
      email: json['email'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
      countryId: json['countryId'],
      companyId: json['companyId'],
      isSubscribed: json['isSubscribed'],
      referralCode: json['referralCode'],
      phoneNumber: json['phoneNumber'],
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['email'] = email;
    _data['password'] = password;
    _data['confirmPassword'] = confirmPassword;
    _data['countryId'] = countryId;
    _data['companyId'] = companyId;
    _data['isSubscribed'] = isSubscribed;
    _data['referralCode'] = referralCode;
    _data['phoneNumber'] = phoneNumber;
    return _data;
  }

  @override
  List<Object?> get props => [email, password, confirmPassword, countryId, companyId, isSubscribed, referralCode, phoneNumber];
}
