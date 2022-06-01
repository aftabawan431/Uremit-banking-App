import 'package:equatable/equatable.dart';

class ProfileImageRequestModel extends Equatable {
  const ProfileImageRequestModel({
    required this.userId,
    required this.image,
  });
  final String userId;
  final String image;

  factory ProfileImageRequestModel.fromJson(Map<String, dynamic> json) {
    return ProfileImageRequestModel(
      userId: json['userId'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['image'] = image;
    return _data;
  }

  @override
  List<Object?> get props => [userId, image];
}
