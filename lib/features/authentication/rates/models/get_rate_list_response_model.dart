import 'package:equatable/equatable.dart';

class GetRateListResponseModel extends Equatable {
  const GetRateListResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.rateListBody,
  });
  final String statusCode;
  final String statusMessage;
  final String traceId;
  final List<RateListBody> rateListBody;

  factory GetRateListResponseModel.fromJson(Map<String, dynamic> json) {
    return GetRateListResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      rateListBody: List.from(json['Body']).map((e) => RateListBody.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = rateListBody.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, rateListBody, traceId];
}

class RateListBody extends Equatable {
  const RateListBody({
    required this.country,
    required this.exchangeRate,
  });
  final Country country;
  final double exchangeRate;

  factory RateListBody.fromJson(Map<String, dynamic> json) {
    return RateListBody(
      country: Country.fromJson(json['country']),
      exchangeRate: json['exchangeRate'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['country'] = country.toJson();
    _data['exchangeRate'] = exchangeRate;
    return _data;
  }

  @override
  List<Object?> get props => [country, exchangeRate];
}

class Country extends Equatable {
  const Country({
    required this.id,
    required this.iso,
    required this.currency,
    required this.name,
    required this.svgPath,
    this.phoneCode,
  });
  final String id;
  final String iso;
  final String currency;
  final String name;
  final String? phoneCode;
  final String svgPath;

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      iso: json['iso'],
      currency: json['currency'],
      name: json['name'],
      svgPath: json['svgPath'],
      phoneCode: json['phoneCode'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['iso'] = iso;
    _data['currency'] = currency;
    _data['name'] = name;
    _data['svgPath'] = svgPath;
    _data['phoneCode'] = phoneCode;
    return _data;
  }

  @override
  List<Object?> get props => [id, iso, currency, name, phoneCode, svgPath];
}
