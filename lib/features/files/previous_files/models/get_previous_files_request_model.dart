import 'package:equatable/equatable.dart';

class GetPreviousFilesRequestModel extends Equatable {
  const GetPreviousFilesRequestModel({
    required this.userId,
  });

  final String userId;

  factory GetPreviousFilesRequestModel.fromJson(Map<String, dynamic> json) {
    return GetPreviousFilesRequestModel(
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
