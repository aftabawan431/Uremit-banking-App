import 'package:equatable/equatable.dart';

class GetAllCardsRequestModel extends Equatable {
  final String id;

  const GetAllCardsRequestModel(this.id);

  factory GetAllCardsRequestModel.fromJson(Map<String, dynamic> json) {
    return GetAllCardsRequestModel(json['id']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    return _data;
  }

  @override
  List<Object?> get props => [id];
}
