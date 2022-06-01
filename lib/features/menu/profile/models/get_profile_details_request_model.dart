import 'package:equatable/equatable.dart';

class GetProfileDetailsRequestModel extends Equatable {
  const GetProfileDetailsRequestModel({required this.id});

  final String id;

  factory GetProfileDetailsRequestModel.fromJson(Map<String, dynamic> json) {
    return GetProfileDetailsRequestModel(
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    return _data;
  }

  @override
  List<Object?> get props => [id];
}
