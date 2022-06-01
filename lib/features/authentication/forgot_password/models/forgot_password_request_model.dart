import 'package:equatable/equatable.dart';

class ForgotPasswordRequestModel extends Equatable{
  const ForgotPasswordRequestModel({required this.email});
  final String email;
  factory ForgotPasswordRequestModel.fromJson(Map<String,dynamic> json){
    return ForgotPasswordRequestModel(
      email: json['email'],
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['email'] = email;
    return _data;
  }

  @override
  List<Object?> get props => [email];

}