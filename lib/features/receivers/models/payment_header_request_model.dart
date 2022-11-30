import 'package:equatable/equatable.dart';

class PaymentHeaderRequestModel extends Equatable {
  const PaymentHeaderRequestModel({required this.userId});
  final String userId;

  factory PaymentHeaderRequestModel.fromJson(Map<String, dynamic> json) {
    return PaymentHeaderRequestModel(userId: json['userId']);
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['userId'] = userId;

    return _data;
  }

  @override
  List<Object?> get props => [userId];
}
