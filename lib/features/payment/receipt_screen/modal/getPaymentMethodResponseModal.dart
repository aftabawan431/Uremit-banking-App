import 'package:equatable/equatable.dart';

class GetPaymentMethodResponseModal extends Equatable {
  GetPaymentMethodResponseModal({
    required this.StatusCode,
    required this.StatusMessage,
    required this.TraceId,
    required this.paymentMethodBodyList,
  });
  final String StatusCode;
  final String StatusMessage;
  final String TraceId;
  final List<PaymentMethodBody> paymentMethodBodyList;

  factory GetPaymentMethodResponseModal.fromJson(Map<String, dynamic> json) {
    return GetPaymentMethodResponseModal(
        StatusCode: json['StatusCode'],
        StatusMessage: json['StatusMessage'],
        TraceId: json['TraceId'],
        paymentMethodBodyList: List.from(json['Body'])
            .map((e) => PaymentMethodBody.fromJson(e))
            .toList());
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = StatusCode;
    _data['StatusMessage'] = StatusMessage;
    _data['TraceId'] = TraceId;
    _data['Body'] = paymentMethodBodyList.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [StatusCode, StatusMessage, TraceId, paymentMethodBodyList];
}

class PaymentMethodBody extends Equatable {
  PaymentMethodBody({
    required this.id,
    required this.name,
    required this.charges,
    required this.adminFee,
    required this.arrivalTime,
    required this.description,
    required this.svgPath
  });
  final int id;
  final String name;
  final String charges;
  final String description;
  final String svgPath;
  final String adminFee;
  final String arrivalTime;

  factory PaymentMethodBody.fromJson(Map<String, dynamic> json) {
    return PaymentMethodBody(
        id: json['id'],
        name: json['name']??'',
        charges: json['charges'].toString(),
    adminFee:json['adminFee'].toString(),
    arrivalTime:json['arrivalTime'].toString(),

      svgPath: json['svgPath']??'',
      description: json['description']??''


    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['charges'] = charges;
    _data['adminFee'] = adminFee;
    _data['svgPath'] = svgPath;
    _data['description'] = description;
    return _data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, charges];
}
