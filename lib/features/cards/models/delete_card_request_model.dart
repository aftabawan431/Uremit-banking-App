import 'package:equatable/equatable.dart';

class DeleteCardRequestModel extends Equatable {
  const DeleteCardRequestModel({
    required this.id,
  });
  final String id;

  factory DeleteCardRequestModel.fromJson(Map<String, dynamic> json) {
    return DeleteCardRequestModel(
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
