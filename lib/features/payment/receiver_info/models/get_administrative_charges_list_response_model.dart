import 'package:logger/logger.dart';

class GetAdministrativeChargesListResponseModel {
  GetAdministrativeChargesListResponseModel({
    required this.StatusCode,
    required this.StatusMessage,
    required this.TraceId,
    required this.Body,
  });
  late final String StatusCode;
  late final String StatusMessage;
  late final String TraceId;
  late final List<GetAdministrativeChargesListResponseModelBody> Body;

  GetAdministrativeChargesListResponseModel.fromJson(Map<String, dynamic> json){
    StatusCode = json['StatusCode'];
    StatusMessage = json['StatusMessage'];
    TraceId = json['TraceId'];
    Body = List.from(json['Body']).map<GetAdministrativeChargesListResponseModelBody>((e)=>GetAdministrativeChargesListResponseModelBody.fromJson(e)).toList();
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

class GetAdministrativeChargesListResponseModelBody {
  GetAdministrativeChargesListResponseModelBody({
    required this.startAmount,
    required this.endAmount,
    required this.charges,
  });
  late final double startAmount;
  late final double endAmount;
  late final double charges;

  GetAdministrativeChargesListResponseModelBody.fromJson(Map<String, dynamic> json){
    startAmount = (json['startAmount'] as num).toDouble();
    endAmount = (json['endAmount'] as num).toDouble();
    charges = (json['charges'] as num).toDouble();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['startAmount'] = startAmount;
    _data['endAmount'] = endAmount;
    _data['charges'] = charges;
    return _data;
  }
}

