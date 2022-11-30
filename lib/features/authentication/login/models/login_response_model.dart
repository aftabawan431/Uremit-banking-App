import 'package:equatable/equatable.dart';

class LoginResponseModel extends Equatable {
  const LoginResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.userDetails,
  });

  final String statusCode;
  final String statusMessage;
  final String traceId;
  final UserDetails userDetails;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      userDetails: UserDetails.fromJson(json['Body']),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = userDetails.toJson();

    return _data;
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, traceId, userDetails];
}

class UserDetails extends Equatable {
  const UserDetails({
    required this.id,
    required this.fullName,
    required this.userName,
    required this.token,
    required this.isVerified,
  });

  final String id;
  final String fullName;
  final String userName;
  final String token;
  final bool isVerified;

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      fullName: json['fullName'] ?? '',
      userName: json['userName'],
      token: json['token'],
      isVerified: json['isVerified']??true,
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['id'] = id;
    _data['fullName'] = fullName;
    _data['userName'] = userName;
    _data['token'] = token;
    _data['isVerified'] = isVerified;
    return _data;
  }

  @override
  List<Object?> get props => [id, fullName, userName, token, isVerified];
}
