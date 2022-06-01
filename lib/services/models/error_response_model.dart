import 'package:equatable/equatable.dart';

class ErrorResponseModel extends Equatable {
  const ErrorResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.body,
  });

  final String? statusCode;
  final String? statusMessage;
  final String? traceId;
  final List<String> body;

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseModel(
      statusCode: json['StatusCode'].toString(),
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      body: json['Body'] == null ? ['Something went wrong'] : List.castFrom<dynamic, String>(json['Body']),
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
  List<Object?> get props => [statusCode, statusMessage, traceId, body];
}
