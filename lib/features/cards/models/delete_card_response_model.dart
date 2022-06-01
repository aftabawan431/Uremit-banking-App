import 'package:equatable/equatable.dart';

class DeleteCardResponseModel extends Equatable {
  const DeleteCardResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.deleteCardResponseModelBody,
  });
  final String statusCode;
  final String statusMessage;
  final String traceId;
  final String deleteCardResponseModelBody;

  factory DeleteCardResponseModel.fromJson(Map<String, dynamic> json) {
    return DeleteCardResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      deleteCardResponseModelBody: json['Body'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = deleteCardResponseModelBody;
    return _data;
  }

  @override
  List<Object?> get props => [
        statusCode,
        statusMessage,
        traceId,
        deleteCardResponseModelBody,
      ];
}

class DeleteCardResponseModelBody extends Equatable {
  const DeleteCardResponseModelBody({
    required this.message,
  });
  final String message;

  factory DeleteCardResponseModelBody.fromJson(Map<String, dynamic> json) {
    return DeleteCardResponseModelBody(
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    return _data;
  }

  @override
  List<Object?> get props => [message];
}
