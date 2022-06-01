import 'package:equatable/equatable.dart';

class ChangePasswordRequestModel extends Equatable {
  const ChangePasswordRequestModel({
    required this.userID,
    required this.oldPassword,
    required this.newPassword,
  });
   final String userID;
   final String oldPassword;
   final String newPassword;

 factory ChangePasswordRequestModel.fromJson(Map<String, dynamic> json){
  return ChangePasswordRequestModel(
      userID : json['userID'],
      oldPassword : json['oldPassword'],
      newPassword : json['newPassword'],
  );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userID'] = userID;
    _data['oldPassword'] = oldPassword;
    _data['newPassword'] = newPassword;
    return _data;
  }

  @override
  List<Object?> get props => [userID,oldPassword,newPassword];
}