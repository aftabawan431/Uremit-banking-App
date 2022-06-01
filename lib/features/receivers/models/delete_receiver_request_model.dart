import 'package:equatable/equatable.dart';

class DeleteReceiverRequestModel extends Equatable {
  const DeleteReceiverRequestModel({
    required this.receiverID,
  });

  final String receiverID;

  factory DeleteReceiverRequestModel.fromJson(Map<String, dynamic> json) {
    return DeleteReceiverRequestModel(
      receiverID: json['receiverID'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['receiverID'] = receiverID;
    return _data;
  }

  @override
  List<Object?> get props => [receiverID];
}
