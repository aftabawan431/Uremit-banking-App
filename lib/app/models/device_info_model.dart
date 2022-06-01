import 'package:equatable/equatable.dart';

class DeviceInfoModel extends Equatable {
  final String imei;
  final String ip;
  final String deviceName;
  final String androidVersion;
  final String appVersion;

  const DeviceInfoModel({required this.imei, required this.ip, required this.deviceName, required this.androidVersion, required this.appVersion});

  @override
  List<Object?> get props => [imei, ip, deviceName, androidVersion, appVersion];
}
