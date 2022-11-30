import 'package:equatable/equatable.dart';

class UpdateTransactionStatusResponseModel extends Equatable {
  const UpdateTransactionStatusResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.body,
  });
  final String statusCode;
  final String statusMessage;
  final String traceId;
  final String body;

  factory UpdateTransactionStatusResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateTransactionStatusResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      body: json['Body'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = body;
    return _data;
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, body, traceId];
}
