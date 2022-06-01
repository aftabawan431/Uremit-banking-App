import 'package:equatable/equatable.dart';

class DeleteReceiverBankListRequestModel extends Equatable {
  const DeleteReceiverBankListRequestModel({
    required this.id,
  });

  final String id;

  factory DeleteReceiverBankListRequestModel.fromJson(Map<String, dynamic> json) {
    return DeleteReceiverBankListRequestModel(
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    return _data;
  }

  @override
  List<Object?> get props => [id];
}
