import 'package:equatable/equatable.dart';

class GetPreviousFileResponseModel extends Equatable {
  const GetPreviousFileResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.previousFileBody,
  });
  final String statusCode;
  final String statusMessage;
  final String traceId;
  final List<PreviousFileBody> previousFileBody;

  factory GetPreviousFileResponseModel.fromJson(Map<String, dynamic> json) {
    return GetPreviousFileResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      previousFileBody: List.from(json['Body']).map((e) => PreviousFileBody.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = previousFileBody.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  List<Object?> get props => [
        statusCode,
        statusMessage,
        traceId,
        previousFileBody,
      ];
}

class PreviousFileBody extends Equatable {
  const PreviousFileBody({
    required this.previousFileId,
    required this.frontFileName,
    required this.backFileName,
    required this.documentType,
    required this.createdDate,
    required this.remarks,
    required this.askedBy,
    required this.frontPath,
    required this.backPath,
  });
  final String previousFileId;
  final String frontFileName;
  final String backFileName;
  final String documentType;
  final String createdDate;
  final String remarks;
  final String askedBy;
  final String frontPath;
  final String backPath;

  factory PreviousFileBody.fromJson(Map<String, dynamic> json) {
    return PreviousFileBody(
      previousFileId: json['previousFileId'] ?? '',
      frontFileName: json['frontFileName'] ?? '',
      backFileName: json['backFileName'] ?? '',
      documentType: json['documentType'] ?? '',
      createdDate: json['createdDate'] ?? '',
      remarks: json['remarks'] ?? '',
      askedBy: json['askedBy'] ?? '',
      frontPath: json['frontPath'] ?? '',
      backPath: json['backPath'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['previousFileId'] = previousFileId;
    _data['frontFileName'] = frontFileName;
    _data['backFileName'] = backFileName;
    _data['documentType'] = documentType;
    _data['createdDate'] = createdDate;
    _data['remarks'] = remarks;
    _data['askedBy'] = askedBy;
    _data['frontPath'] = frontPath;
    _data['backPath'] = backPath;
    return _data;
  }

  @override
  List<Object?> get props => [previousFileId, frontFileName, backFileName, documentType, createdDate, remarks, askedBy, frontPath, backPath];
}
