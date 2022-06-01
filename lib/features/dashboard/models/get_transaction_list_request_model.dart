import 'package:equatable/equatable.dart';

class GetTransactionListRequestModel extends Equatable {
  const GetTransactionListRequestModel({required this.userId, required this.statusDescription});

  final String userId;
  final String statusDescription;

  factory GetTransactionListRequestModel.fromJson(Map<String, dynamic> json) {
    return GetTransactionListRequestModel(
      userId: json['userId'],
      statusDescription: json['statusDescription'],
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['userId'] = userId;
    _data['statusDescription'] = statusDescription;

    return _data;
  }

  @override
  List<Object?> get props => [userId, statusDescription];
}
