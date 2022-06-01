import 'package:equatable/equatable.dart';

class DocTypeResponseModel extends Equatable {
  const DocTypeResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.docTypes,
  });

  final String statusCode;
  final String statusMessage;
  final String traceId;
  final List<DocTypeBody> docTypes;

  factory DocTypeResponseModel.fromJson(Map<String, dynamic> json) {
    return DocTypeResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      docTypes: List.from(json['Body']).map((e) => DocTypeBody.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = docTypes.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, docTypes, traceId];
}

class DocTypeBody extends Equatable {
  const DocTypeBody({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory DocTypeBody.fromJson(Map<String, dynamic> json) {
    return DocTypeBody(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }

  @override
  List<Object?> get props => [id, name];
}
