import 'package:equatable/equatable.dart';

class GetBankListRequestModel extends Equatable {
  const GetBankListRequestModel(this.countryId);
  final String countryId;

  factory GetBankListRequestModel.fromJson(Map<String, dynamic> json) {
    return GetBankListRequestModel(json['countryId']);
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['countryId'] = countryId;

    return _data;
  }

  @override
  List<Object?> get props => [countryId];
}
