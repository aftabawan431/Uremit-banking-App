import 'package:equatable/equatable.dart';

class GenerateOtpRequestModel extends Equatable {
  final String email;
  final int otpType;

  const GenerateOtpRequestModel(this.email, this.otpType);

  factory GenerateOtpRequestModel.fromJson(Map<String, dynamic> json) {
    return GenerateOtpRequestModel(
      json['email'],
      json['otpType'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['otpType'] = otpType;
    return _data;
  }

  @override
  List<Object?> get props => [email, otpType];
}
