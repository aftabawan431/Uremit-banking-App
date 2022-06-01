import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

class ProfileHeaderResponseModel extends Equatable {
  const ProfileHeaderResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.profileHeaderBody,
  });
  final String statusCode;
  final String statusMessage;
  final String traceId;
  final List<ProfileHeaderBody> profileHeaderBody;

  factory ProfileHeaderResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileHeaderResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      profileHeaderBody: List.from(json['Body']).map((e) => ProfileHeaderBody.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['traceId'] = traceId;
    _data['Body'] = profileHeaderBody.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, traceId, profileHeaderBody];
}

class ProfileHeaderBody extends Equatable {
  const ProfileHeaderBody({
    required this.dashboardProfileId,
    required this.userID,
    required this.fullName,
    required this.firstName,
    required this.email,
    required this.phoneNo,
    required this.isVerified,
    required this.userImage,
  });
  final String dashboardProfileId;
  final String userID;
  final String fullName;
  final String firstName;
  final String email;
  final String phoneNo;
  final bool isVerified;
  final String userImage;

  factory ProfileHeaderBody.fromJson(Map<String, dynamic> json) {


    return ProfileHeaderBody(
      dashboardProfileId: json['dashboardProfileId'] ?? 'N/A',
      userID: json['userID'] ?? 'N/A',
      fullName: json['fullName'] ?? '',
      firstName: json['firstName'] ?? 'N/A',
      email: json['email'] ?? 'N/A',
      phoneNo: json['phoneNo'] ?? 'N/A',
      isVerified: json['isVerified'],
      userImage: json['userImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['dashboardProfileId'] = dashboardProfileId;
    _data['userID'] = userID;
    _data['fullName'] = fullName;
    _data['firstName'] = firstName;
    _data['email'] = email;
    _data['phoneNo'] = phoneNo;
    _data['isVerified'] = isVerified;
    _data['userImage'] = userImage;
    return _data;
  }

  @override
  List<Object?> get props => [dashboardProfileId, userID, fullName, firstName, email, phoneNo, isVerified, userImage];
}
