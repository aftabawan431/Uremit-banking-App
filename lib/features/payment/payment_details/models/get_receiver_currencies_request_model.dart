class GetReceiverCurrenciesRequestModel {
  GetReceiverCurrenciesRequestModel({
    required this.id,
  });
  late final String id;

  GetReceiverCurrenciesRequestModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    return _data;
  }
}