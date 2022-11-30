import 'package:equatable/equatable.dart';

class GetPaymentMethodResponseModal {
  GetPaymentMethodResponseModal({
    required this.StatusCode,
    required this.StatusMessage,
    required this.TraceId,
    required this.paymentMethodBodyList,
  });
  late final String StatusCode;
  late final String StatusMessage;
  late final String TraceId;
  late final List<PaymentMethodBody> paymentMethodBodyList;

  GetPaymentMethodResponseModal.fromJson(Map<String, dynamic> json) {
    StatusCode = json['StatusCode'];
    StatusMessage = json['StatusMessage'];
    TraceId = json['TraceId'];
    paymentMethodBodyList = List.from(json['Body'])
        .map((e) => PaymentMethodBody.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = StatusCode;
    _data['StatusMessage'] = StatusMessage;
    _data['TraceId'] = TraceId;
    _data['Body'] = paymentMethodBodyList.map((e) => e.toJson()).toList();
    return _data;
  }
}

class PaymentMethodBody {
  PaymentMethodBody({
    required this.id,
    required this.name,
    required this.charges,
    required this.title,
    required this.description,
    required this.svgPath,
    required this.paymentGatewayId,
    required this.adminFee,
    required this.arrivalTime,
    required this.exchangeRate,
  });

  late final int id;
  late final String name;
  late final double? charges;
  late final String title;
  late final String description;
  late final String svgPath;
  late final int paymentGatewayId;
  late final int adminFee;
  late final double arrivalTime;
  late final double exchangeRate;

  PaymentMethodBody.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    charges = json['charges'];
    title = json['title'];
    description = json['description'];
    svgPath = json['svgPath'];
    paymentGatewayId = json['paymentGatewayId'];
    adminFee = json['adminFee'];
    arrivalTime = (json['arrivalTime'] as num).toDouble();
    exchangeRate = (json['exchangeRate'] as num).toDouble();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['charges'] = charges;
    _data['title'] = title;
    _data['description'] = description;
    _data['svgPath'] = svgPath;
    _data['paymentGatewayId'] = paymentGatewayId;
    _data['adminFee'] = adminFee;
    _data['arrivalTime'] = arrivalTime;
    _data['exchangeRate'] = exchangeRate;
    return _data;
  }
}
