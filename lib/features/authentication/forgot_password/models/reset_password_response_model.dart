import 'package:equatable/equatable.dart';

class ResetPasswordResponseModel extends Equatable {
  const ResetPasswordResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.resetPasswordBody,
  });

  final String statusCode;
  final String statusMessage;
  final String traceId;
  final ResetPasswordBody resetPasswordBody;

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      resetPasswordBody: ResetPasswordBody.fromJson(json['Body']),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = resetPasswordBody.toJson();
    return _data;
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, traceId, resetPasswordBody];
}

class ResetPasswordBody extends Equatable {
  const ResetPasswordBody({
    required this.message,
  });

  final String message;

  factory ResetPasswordBody.fromJson(Map<String, dynamic> json) {
    return ResetPasswordBody(message: json['message']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    return _data;
  }

  @override
  List<Object?> get props => [message];
}
