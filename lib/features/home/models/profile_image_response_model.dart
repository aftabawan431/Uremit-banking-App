import 'package:equatable/equatable.dart';

class ProfileImageResponseModel extends Equatable {
  const ProfileImageResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.profileImageResponseBody,
  });
  final String statusCode;
  final String statusMessage;
  final String traceId;
  final String profileImageResponseBody;

  factory ProfileImageResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileImageResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      profileImageResponseBody: json['Body'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = profileImageResponseBody;
    return _data;
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, traceId, profileImageResponseBody];
}
