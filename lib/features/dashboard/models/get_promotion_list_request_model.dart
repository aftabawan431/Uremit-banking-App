import 'package:equatable/equatable.dart';

class GetPromotionListRequestModel extends Equatable {
  const GetPromotionListRequestModel({required this.id});
  final String id;

  factory GetPromotionListRequestModel.fromJson(Map<String, dynamic> json) {
    return GetPromotionListRequestModel(id: json['id']);
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['id'] = id;

    return _data;
  }

  @override
  List<Object?> get props => [id];
}
