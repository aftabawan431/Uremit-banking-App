import 'package:equatable/equatable.dart';

class LogoutRequestModel extends Equatable {
  const LogoutRequestModel({required this.userId});

  final String userId;

  factory LogoutRequestModel.fromJson(Map<String, dynamic> json) {
    return LogoutRequestModel(
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    return _data;
  }

  @override
  List<Object?> get props => [userId];
}
