import 'package:equatable/equatable.dart';

class GetBankListResponseModel extends Equatable {
  const GetBankListResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.getBankListResponseModelBody,
  });
  final String statusCode;
  final String statusMessage;
  final String traceId;
  final List<GetBankListResponseModelBody> getBankListResponseModelBody;

  factory GetBankListResponseModel.fromJson(Map<String, dynamic> json) {
    return GetBankListResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      getBankListResponseModelBody: List.from(json['Body']).map((e) => GetBankListResponseModelBody.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = getBankListResponseModelBody.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, traceId, getBankListResponseModelBody];
}

class GetBankListResponseModelBody extends Equatable {
  const GetBankListResponseModelBody({
    required this.bankId,
    required this.name,
  });
  final int bankId;
  final String name;

  factory GetBankListResponseModelBody.fromJson(Map<String, dynamic> json) {
    return GetBankListResponseModelBody(
      bankId: json['bankId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bankId'] = bankId;
    _data['name'] = name;
    return _data;
  }

  @override
  List<Object?> get props => [
        bankId,
        name,
      ];
}
