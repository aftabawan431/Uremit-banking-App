import 'package:equatable/equatable.dart';

class CountriesProvinceRequestModel extends Equatable {
  final String id;

  const CountriesProvinceRequestModel(this.id);

  factory CountriesProvinceRequestModel.fromJson(Map<String, dynamic> json) {
    return CountriesProvinceRequestModel(json['id']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    return _data;
  }

  @override
  List<Object?> get props => [id];
}
