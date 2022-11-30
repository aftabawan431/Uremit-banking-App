import 'package:equatable/equatable.dart';

class GetAdministrativeChargesListRequestModel extends Equatable {
  const GetAdministrativeChargesListRequestModel({required this.id});

  final String id;

  factory GetAdministrativeChargesListRequestModel.fromJson(Map<String, dynamic> json) {
    return GetAdministrativeChargesListRequestModel(
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