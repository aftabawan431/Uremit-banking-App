import 'package:equatable/equatable.dart';

class RegistrationResponseModel extends Equatable {
  const RegistrationResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.registrationDetails,
  });

  final String statusCode;
  final String statusMessage;
  final String traceId;
  final RegistrationDetails registrationDetails;

  factory RegistrationResponseModel.fromJson(Map<String, dynamic> json) {
    return RegistrationResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      registrationDetails: RegistrationDetails.fromJson(json['Body']),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = registrationDetails.toJson();
    return _data;
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, traceId, registrationDetails];
}

class RegistrationDetails extends Equatable {
  const RegistrationDetails({
    required this.message,
  });
  final String message;

  factory RegistrationDetails.fromJson(Map<String, dynamic> json) {
    return RegistrationDetails(
      message: json['message'],
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['message'] = message;

    return _data;
  }

  @override
  List<Object?> get props => [message];
}
