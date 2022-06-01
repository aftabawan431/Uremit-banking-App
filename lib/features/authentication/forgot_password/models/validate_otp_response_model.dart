import 'package:equatable/equatable.dart';

class ValidateOtpResponseModel extends Equatable {
  const ValidateOtpResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.otpBody,
  });

  final String statusCode;
  final String statusMessage;
  final String traceId;
  final OtpBody otpBody;

  factory ValidateOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return ValidateOtpResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      otpBody: OtpBody.fromJson(json['Body']),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = otpBody.toJson();
    return _data;
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, traceId, otpBody];
}

class OtpBody extends Equatable {
  const OtpBody({
    required this.result,
    required this.userID,
  });

  final bool result;
  final String userID;

  factory OtpBody.fromJson(Map<String, dynamic> json) {
    return OtpBody(
      result: json['result'],
      userID: json['userID'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['result'] = result;
    _data['userID'] = userID;
    return _data;
  }

  @override
  List<Object?> get props => [result, userID];
}
