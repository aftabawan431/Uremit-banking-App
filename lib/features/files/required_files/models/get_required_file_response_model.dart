import 'package:equatable/equatable.dart';

class GetRequiredFileResponseModel extends Equatable {
  const GetRequiredFileResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.getProfileRequestBody,
  });
  final String statusCode;
  final String statusMessage;
  final String traceId;
  final List<GetRequiredFilesResponseModelBody> getProfileRequestBody;

  factory GetRequiredFileResponseModel.fromJson(Map<String, dynamic> json) {
    return GetRequiredFileResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      getProfileRequestBody: List.from(json['Body']).map((e) => GetRequiredFilesResponseModelBody.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = getProfileRequestBody.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  List<Object?> get props => [
        statusCode,
        statusMessage,
        traceId,
        getProfileRequestBody,
      ];
}

class GetRequiredFilesResponseModelBody extends Equatable {
  const GetRequiredFilesResponseModelBody({
    required this.id,
    required this.frontFileName,
    required this.backFileName,
    required this.documentType,
    required this.documentTypeId,
    required this.frontPath,
    required this.createdDate,
    required this.askedBy,
    required this.backPath,
    required this.remarks,
  });
  final String id;
  final String frontFileName;
  final String backFileName;
  final String documentType;
  final String documentTypeId;
  final String frontPath;
  final String createdDate;
  final String askedBy;
  final String backPath;
  final String remarks;

  factory GetRequiredFilesResponseModelBody.fromJson(Map<String, dynamic> json) {
    return GetRequiredFilesResponseModelBody(
      id: json['id'] ?? '',
      frontFileName: json['frontFileName'] ?? '',
      backFileName: json['backFileName'] ?? '',
      documentType: json['documentType'] ?? '',
      documentTypeId: json['documentTypeId'] ?? '',
      frontPath: json['frontPath'] ?? '',
      createdDate: json['createdDate'] ?? '',
      askedBy: json['askedBy'] ?? '',
      backPath: json['backPath'] ?? '',
      remarks: json['remarks'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['frontFileName'] = frontFileName;
    _data['backFileName'] = backFileName;
    _data['documentType'] = documentType;
    _data['documentTypeId'] = documentTypeId;
    _data['frontPath'] = frontPath;
    _data['createdDate'] = createdDate;
    _data['askedBy'] = askedBy;
    _data['backPath'] = backPath;
    _data['remarks'] = remarks;

    return _data;
  }

  @override
  List<Object?> get props => [
        id,
        frontFileName,
        createdDate,
        backFileName,
        documentType,
        documentTypeId,
        frontPath,
        createdDate,
        askedBy,
        backPath,
        remarks,
      ];
}
