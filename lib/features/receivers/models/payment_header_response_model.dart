import 'package:equatable/equatable.dart';

class PaymentHeaderResponseModel extends Equatable {
  const PaymentHeaderResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.paymentHeaderResponseModelBody,
  });
  final String statusCode;
  final String statusMessage;
  final String traceId;
  final PaymentHeaderResponseModelBody paymentHeaderResponseModelBody;

  factory PaymentHeaderResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentHeaderResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      paymentHeaderResponseModelBody: PaymentHeaderResponseModelBody.fromJson(json['Body']),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = paymentHeaderResponseModelBody.toJson();
    return _data;
  }

  @override
  List<Object?> get props => [
        statusCode,
        statusMessage,
        traceId,
        paymentHeaderResponseModelBody,
      ];
}

class PaymentHeaderResponseModelBody extends Equatable {
  const PaymentHeaderResponseModelBody({
    required this.senderCountryUnitValue,
    required this.birthCountryExchangeValue,
  });
  final String senderCountryUnitValue;
  final String birthCountryExchangeValue;

  factory PaymentHeaderResponseModelBody.fromJson(Map<String, dynamic> json) {
    return PaymentHeaderResponseModelBody(
      senderCountryUnitValue: json['senderCountryUnitValue'] ?? '',
      birthCountryExchangeValue: json['birthCountryExchangeValue'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['senderCountryUnitValue'] = senderCountryUnitValue;
    _data['birthCountryExchangeValue'] = birthCountryExchangeValue;
    return _data;
  }

  @override
  List<Object?> get props => [senderCountryUnitValue, birthCountryExchangeValue];
}
