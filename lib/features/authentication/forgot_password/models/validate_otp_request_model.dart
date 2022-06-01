import 'package:equatable/equatable.dart';

class ValidateOtpRequestModel extends Equatable {
  const ValidateOtpRequestModel({required this.otpCode, required this.otpType, required this.email});
  final int otpType;
  final String otpCode;
  final String email;
  factory ValidateOtpRequestModel.fromJson(Map<String, dynamic> json) {
    return ValidateOtpRequestModel(
      otpCode: json['otpCode'],
      otpType: json['otpType'],
      email: json['email'],
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['otpCode'] = otpCode;
    _data['otpType'] = otpType;
    _data['email'] = email;
    return _data;
  }

  @override
  List<Object?> get props => [otpType, otpCode, email];
}
