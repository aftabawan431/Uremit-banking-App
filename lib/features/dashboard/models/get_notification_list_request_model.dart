import 'package:equatable/equatable.dart';

class GetNotificationListRequestModel extends Equatable {
  const GetNotificationListRequestModel({required this.userId, required this.pageSize, required this.startIndex});
  final String userId;
  final int pageSize;
  final int startIndex;

  factory GetNotificationListRequestModel.fromJson(Map<String, dynamic> json) {
    return GetNotificationListRequestModel(
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
