import 'package:equatable/equatable.dart';

class ReceiverListRequestModel extends Equatable {
  const ReceiverListRequestModel({required this.id});
  final String id;

  factory ReceiverListRequestModel.fromJson(Map<String, dynamic> json) {
    return ReceiverListRequestModel(id: json['id']);
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['id'] = id;

    return _data;
  }

  @override
  List<Object?> get props => [id];
}
