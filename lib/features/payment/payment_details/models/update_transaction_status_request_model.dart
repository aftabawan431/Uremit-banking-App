import 'package:equatable/equatable.dart';

class UpdateTransactionStatusRequestModel extends Equatable {
  const UpdateTransactionStatusRequestModel({
    required this.txn,
  });
  final String txn;

  factory UpdateTransactionStatusRequestModel.fromJson(Map<String, dynamic> json) {
    return UpdateTransactionStatusRequestModel(
      txn: json['txn'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['txn'] = txn;
    return _data;
  }

  @override
  List<Object?> get props => [txn];
}
