import 'package:equatable/equatable.dart';

class ChangePasswordResponseModel extends Equatable {
  const ChangePasswordResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.changePasswordBody,
  });

  final String statusCode;
  final String statusMessage;
  final String traceId;
  final ChangePasswordBody changePasswordBody;

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      changePasswordBody: ChangePasswordBody.fromJson(json['Body']),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = changePasswordBody.toJson();
    return _data;
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, traceId, changePasswordBody];
}

class ChangePasswordBody extends Equatable {
  const ChangePasswordBody({
    required this.message,
  });
  final String message;

  factory ChangePasswordBody.fromJson(Map<String, dynamic> json) {
    return ChangePasswordBody(
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
