import 'package:equatable/equatable.dart';

class GetPaymentRateListResponseModal extends Equatable {
  const GetPaymentRateListResponseModal({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.getPaymentRateListResponseBody,
  });
  final String statusCode;
  final String statusMessage;
  final String traceId;
  final List<GetPaymentRateListResponseBody> getPaymentRateListResponseBody;

  factory GetPaymentRateListResponseModal.fromJson(Map<String, dynamic> json) {
    return GetPaymentRateListResponseModal(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      getPaymentRateListResponseBody: json['Body'].map<GetPaymentRateListResponseBody>((e) => GetPaymentRateListResponseBody.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = getPaymentRateListResponseBody.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  List<Object?> get props => [
        statusCode,
        statusMessage,
        traceId,
        getPaymentRateListResponseBody,
      ];
}

class GetPaymentRateListResponseBody extends Equatable {
  const GetPaymentRateListResponseBody({
    required this.country,
    required this.payoutMethod,
    required this.payoutPartner,
    required this.exchangeRate,
  });
  final CountryPayment country;
  final PayoutMethod payoutMethod;
  final PayoutPartner payoutPartner;
  final double exchangeRate;

  factory GetPaymentRateListResponseBody.fromJson(Map<String, dynamic> json) {
    return GetPaymentRateListResponseBody(
        country: CountryPayment.fromJson(json['country']),
        payoutMethod: PayoutMethod.fromJson(json['payoutMethod']),
        payoutPartner: PayoutPartner.fromJson(json['payoutPartner']),
        exchangeRate: (json['exchangeRate'] as num).toDouble());
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['country'] = country.toJson();
    _data['payoutMethod'] = payoutMethod.toJson();
    _data['payoutPartner'] = payoutPartner.toJson();
    _data['exchangeRate'] = exchangeRate;
    return _data;
  }

  @override
  List<Object?> get props => [
        country,
        payoutMethod,
        payoutPartner,
        exchangeRate,
      ];
}

class CountryPayment extends Equatable {
  const CountryPayment({
    required this.id,
    required this.iso,
    required this.currency,
    required this.name,
    required this.phoneCode,
    required this.svgPath,
  });
  final String id;
  final String iso;
  final String currency;
  final String name;
  final String phoneCode;
  final String svgPath;

  factory CountryPayment.fromJson(Map<String, dynamic> json) {
    return CountryPayment(
      id: json['id'],
      iso: json['iso'],
      currency: json['currency'],
      name: json['name'],
      phoneCode: json['phoneCode'],
      svgPath: json['svgPath'] == null ? '' : json['svgPath'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['iso'] = iso;
    _data['currency'] = currency;
    _data['name'] = name;
    _data['phoneCode'] = phoneCode;
    _data['svgPath'] = svgPath;
    return _data;
  }

  @override
  List<Object?> get props => [
        id,
        iso,
        currency,
        name,
        phoneCode,
        svgPath,
      ];
}

class PayoutMethod extends Equatable {
  const PayoutMethod({
    required this.id,
    required this.name,
    required this.fee,
  });
  final String id;
  final String name;
  final double fee;

  factory PayoutMethod.fromJson(Map<String, dynamic> json) {
    return PayoutMethod(
      id: json['id'],
      name: json['name'],
      fee: (json['fee'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['fee'] = fee;
    return _data;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        fee,
      ];
}

class PayoutPartner extends Equatable {
  const PayoutPartner({
    required this.id,
    required this.name,
    required this.fee,
  });
  final String id;
  final String name;
  final double fee;

  factory PayoutPartner.fromJson(Map<String, dynamic> json) {
    return PayoutPartner(
      id: json['id'],
      name: json['name'],
      fee: (json['fee'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['fee'] = fee;
    return _data;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        fee,
      ];
}
