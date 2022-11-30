import 'package:equatable/equatable.dart';

class GetUremitBanksCountriesResponseModel extends Equatable {
  const GetUremitBanksCountriesResponseModel({
    required this.StatusCode,
    required this.StatusMessage,
    required this.TraceId,
    required this.Body,
  });
  final String StatusCode;
  final String StatusMessage;
  final String TraceId;
  final List<GetUremitBanksCountriesResponseModelBody> Body;

  factory GetUremitBanksCountriesResponseModel.fromJson(Map<String, dynamic> json) {
    return GetUremitBanksCountriesResponseModel(
      StatusCode: json['StatusCode'],
      StatusMessage: json['StatusMessage'],
      TraceId: json['TraceId'],
      Body: List.from(json['Body']).map((e) => GetUremitBanksCountriesResponseModelBody.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = StatusCode;
    _data['StatusMessage'] = StatusMessage;
    _data['TraceId'] = TraceId;
    _data['Body'] = Body.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  List<Object?> get props => [
        StatusCode,
        StatusMessage,
        TraceId,
        Body,
      ];
}

class GetUremitBanksCountriesResponseModelBody extends Equatable {
  GetUremitBanksCountriesResponseModelBody({
    required this.countryId,
    required this.countryName,
    required this.countryCode,
    required this.iso3,
    required this.isSelected,
    required this.iso,
    required this.svgPath,
  });
  final String countryId;
  final String countryName;
  final String countryCode;
  final String iso3;
  final bool isSelected;
  final String iso;
  final String svgPath;

  factory GetUremitBanksCountriesResponseModelBody.fromJson(Map<String, dynamic> json) {
    return GetUremitBanksCountriesResponseModelBody(
      countryId: json['countryId'],
      countryName: json['countryName'],
      countryCode: json['countryCode'],
      iso3: json['iso3'],
      isSelected: json['isSelected'],
      iso: json['iso'],
      svgPath: json['svgPath'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['countryId'] = countryId;
    _data['countryName'] = countryName;
    _data['countryCode'] = countryCode;
    _data['iso3'] = iso3;
    _data['isSelected'] = isSelected;
    _data['iso'] = iso;
    _data['svgPath'] = svgPath;
    return _data;
  }

  @override
  List<Object?> get props => [countryId, countryName, countryCode, iso3, isSelected, iso, svgPath];
}
