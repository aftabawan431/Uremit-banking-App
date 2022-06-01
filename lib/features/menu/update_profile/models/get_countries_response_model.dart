import 'package:equatable/equatable.dart';

class GetCountriesResponseModel extends Equatable {
  const GetCountriesResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.body,
  });
  final String statusCode;
  final String statusMessage;
  final String traceId;
  final List<CountriesBody> body;

  factory GetCountriesResponseModel.fromJson(Map<String, dynamic> json) {
    return GetCountriesResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      body: List.from(json['Body']).map((e) => CountriesBody.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = body.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, traceId, body];
}

class CountriesBody extends Equatable {
  const CountriesBody({
    required this.countryId,
    required this.countryName,
    required this.countryCode,
    required this.svgPath,
    required this.isoCode,
    required this.nationality,
  });
  final String countryId;
  final String countryName;
  final int countryCode;
  final String svgPath;
  final String isoCode;
  final String nationality;

  factory CountriesBody.fromJson(Map<String, dynamic> json) {
    return CountriesBody(
      countryId: json['countryId'],
      countryName: json['countryName'],
      countryCode: json['countryCode'],
      svgPath: json['svgPath'],
      isoCode: json['iso'],
      nationality: json['nationality'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['countryId'] = countryId;
    _data['countryName'] = countryName;
    _data['countryCode'] = countryCode;
    _data['iso'] = isoCode;
    _data['svgPath'] = svgPath;
    _data['nationality'] = nationality;
    return _data;
  }

  @override
  List<Object?> get props => [countryId, countryName, countryCode, isoCode, nationality, svgPath];
}
