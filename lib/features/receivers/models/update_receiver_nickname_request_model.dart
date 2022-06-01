import 'package:equatable/equatable.dart';

class UpdateReceiverNicknameRequestModel extends Equatable {
  const UpdateReceiverNicknameRequestModel({
    required this.receiverID,
    required this.nickName,
  });
  final String receiverID;
  final String nickName;

  factory UpdateReceiverNicknameRequestModel.fromJson(Map<String, dynamic> json) {
    return UpdateReceiverNicknameRequestModel(
      receiverID: json['receiverID'],
      nickName: json['nickName'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['receiverID'] = receiverID;
    _data['nickName'] = nickName;
    return _data;
  }

  @override
  List<Object?> get props => [];
}
