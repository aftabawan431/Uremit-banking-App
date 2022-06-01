import 'package:equatable/equatable.dart';

class GetMobileNotificationListRequestModel extends Equatable {
  const GetMobileNotificationListRequestModel({required this.userId, required this.pageSize, required this.startIndex});
  final String userId;
  final int pageSize;
  final int startIndex;

  factory GetMobileNotificationListRequestModel.fromJson(Map<String, dynamic> json) {
    return GetMobileNotificationListRequestModel(
      userId: json['userId'],
      pageSize: json['pageSize'],
      startIndex: json['startIndex'],
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['userId'] = userId;
    _data['pageSize'] = pageSize;
    _data['startIndex'] = startIndex;

    return _data;
  }

  @override
  List<Object?> get props => [pageSize, userId, startIndex];
}
