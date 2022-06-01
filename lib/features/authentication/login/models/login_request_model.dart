import 'package:equatable/equatable.dart';

class LoginRequestModel extends Equatable {
  const LoginRequestModel({
    required this.clientId,
    required this.email,
    required this.password,
    required this.imei,
    required this.ip,
    required this.deviceName,
    required this.androidVersion,
    required this.appVersion,
    required this.dateTime,
    required this.rememberMe,
  });

  final int clientId;
  final String email;
  final String password;
  final String imei;
  final String ip;
  final String deviceName;
  final String androidVersion;
  final String appVersion;
  final String dateTime;
  final bool rememberMe;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      clientId: json['clientId'],
      email: json['email'],
      password: json['password'],
      imei: json['imei'],
      ip: json['ip'],
      deviceName: json['deviceName'],
      androidVersion: json['androidVersion'],
      appVersion: json['appVersion'],
      dateTime: json['dateTime'],
      rememberMe: json['rememberMe'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['clientId'] = clientId;
    _data['email'] = email;
    _data['password'] = password;
    _data['imei'] = imei;
    _data['ip'] = ip;
    _data['deviceName'] = deviceName;
    _data['androidVersion'] = androidVersion;
    _data['appVersion'] = appVersion;
    _data['dateTime'] = dateTime;
    _data['rememberMe'] = rememberMe;
    return _data;
  }

  @override
  List<Object?> get props => [clientId, email, password, imei, ip, deviceName, androidVersion, appVersion, dateTime, rememberMe];
}
