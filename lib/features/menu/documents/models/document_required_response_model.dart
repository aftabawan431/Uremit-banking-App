import 'package:equatable/equatable.dart';

class DocumentRequiredResponseModel extends Equatable {
  const DocumentRequiredResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.docTypes,
  });

  final String statusCode;
  final String statusMessage;
  final String traceId;
  final String docTypes;

  factory DocumentRequiredResponseModel.fromJson(Map<String, dynamic> json) {
    return DocumentRequiredResponseModel(
      statusCode: json['StatusCode'].toString(),
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      docTypes: json['Body'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = docTypes;
    return _data;
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, docTypes, traceId];
}

class DocumentRequiredResponseModelBody extends Equatable {
  const DocumentRequiredResponseModelBody({
    required this.body,
  });

  final String body;

  factory DocumentRequiredResponseModelBody.fromJson(Map<String, dynamic> json) {
    return DocumentRequiredResponseModelBody(
      body: json['Body'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Body'] = body;

    return _data;
  }

  @override
  List<Object?> get props => [
        body,
      ];
}
