import 'package:equatable/equatable.dart';

class CountriesProvinceResponseModel extends Equatable {
  const CountriesProvinceResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.provinces,
  });

  final String statusCode;
  final String statusMessage;
  final String traceId;
  final List<CountriesProvinceBody> provinces;

  factory CountriesProvinceResponseModel.fromJson(Map<String, dynamic> json) {
    return CountriesProvinceResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      provinces: List.from(json['Body']).map((e) => CountriesProvinceBody.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = provinces.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, provinces, traceId];
}

class CountriesProvinceBody extends Equatable {
  const CountriesProvinceBody({
    required this.id,
    required this.countryId,
    required this.stateName,
  });

  final String id;
  final String countryId;
  final String stateName;

  factory CountriesProvinceBody.fromJson(Map<String, dynamic> json) {
    return CountriesProvinceBody(
      id: json['id'],
      countryId: json['countryId'],
      stateName: json['stateName'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['countryId'] = countryId;
    _data['stateName'] = stateName;
    return _data;
  }

  @override
  List<Object?> get props => [id, countryId, stateName];
}
