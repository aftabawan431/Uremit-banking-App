
  class GetReceiverCurrenciesResponseModel {
  GetReceiverCurrenciesResponseModel({
  required this.StatusCode,
  required this.StatusMessage,
  required this.TraceId,
  required this.Body,
  });
  late final String StatusCode;
  late final String StatusMessage;
  late final String TraceId;
  late final List<Currency> Body;

  GetReceiverCurrenciesResponseModel.fromJson(Map<String, dynamic> json){
  StatusCode = json['StatusCode'];
  StatusMessage = json['StatusMessage'];
  TraceId = json['TraceId'];
  Body = List.from(json['Body']).map((e)=>Currency.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['StatusCode'] = StatusCode;
  _data['StatusMessage'] = StatusMessage;
  _data['TraceId'] = TraceId;
  _data['Body'] = Body.map((e)=>e.toJson()).toList();
  return _data;
  }
  }

  class Currency {
  Currency({
  required this.id,
  required this.name,
  required this.code,
  });
  late final String id;
  late final String name;
  late final String code;

  Currency.fromJson(Map<String, dynamic> json){
  id = json['id'];
  name = json['name'];
  code = json['currencyCode'];
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['id'] = id;
  _data['name'] = name;
  _data['currencyCode'] = code;
  return _data;
  }
  }