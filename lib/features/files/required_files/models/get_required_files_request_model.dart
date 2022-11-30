import 'package:equatable/equatable.dart';

class GetRequiredFileRequestModel extends Equatable {
  const GetRequiredFileRequestModel({
    required this.id,
  });
  final String id;

  factory GetRequiredFileRequestModel.fromJson(Map<String, dynamic> json) {
    return GetRequiredFileRequestModel(
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
