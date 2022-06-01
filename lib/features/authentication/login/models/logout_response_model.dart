import 'package:equatable/equatable.dart';

class LogoutResponseModel extends Equatable {
  const LogoutResponseModel({
    required this.StatusCode,
    required this.StatusMessage,
    required this.TraceId,
    required this.logoutResponseModelBody,
  });
  final String StatusCode;
  final String StatusMessage;
  final String TraceId;
  final LogoutResponseModelBody logoutResponseModelBody;

  factory LogoutResponseModel.fromJson(Map<String, dynamic> json) {
    return LogoutResponseModel(
        StatusCode: json['StatusCode'], StatusMessage: json['StatusMessage'], TraceId: json['TraceId'], logoutResponseModelBody: LogoutResponseModelBody.fromJson(json['Body']));
    ;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = StatusCode;
    _data['StatusMessage'] = StatusMessage;
    _data['TraceId'] = TraceId;
    _data['Body'] = logoutResponseModelBody.toJson();
    return _data;
  }

  @override
  List<Object?> get props => [
        StatusCode,
        StatusMessage,
        TraceId,
      ];
}

class LogoutResponseModelBody extends Equatable {
  const LogoutResponseModelBody({
    required this.message,
  });
  final String message;

  factory LogoutResponseModelBody.fromJson(Map<String, dynamic> json) {
    return LogoutResponseModelBody(
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
