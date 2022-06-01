import 'package:equatable/equatable.dart';

class ResetPasswordRequestModel extends Equatable{
  const ResetPasswordRequestModel({required this.userId,required this.password,required this.otpCode});
  final String userId;
  final String password;
  final String otpCode;
  factory ResetPasswordRequestModel.fromJson(Map<String,dynamic> json){
    return ResetPasswordRequestModel(
      userId: json['userId'],
      password: json['password'],
      otpCode: json['otpCode'],
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['userId'] = userId;
    _data['password'] = password;
    _data['otpCode'] = otpCode;
    return _data;
  }

  @override
  List<Object?> get props => [userId,password,otpCode];

}