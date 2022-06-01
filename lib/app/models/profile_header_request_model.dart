import 'package:equatable/equatable.dart';

class ProfileHeaderRequestModel extends Equatable {
  const ProfileHeaderRequestModel({
    required this.userId,
  });
  final String userId;

  factory ProfileHeaderRequestModel.fromJson(Map<String, dynamic> json) {
    return ProfileHeaderRequestModel(
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
