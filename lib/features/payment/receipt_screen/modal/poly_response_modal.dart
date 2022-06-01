import 'package:logger/logger.dart';

class PolyResponseModal {
  PolyResponseModal({
    required this.StatusCode,
    required this.StatusMessage,
    required this.TraceId,
    required this.Body,
  });
  late final String StatusCode;
  late final String StatusMessage;
  late final String TraceId;
  late final PolyResponseBody Body;

  PolyResponseModal.fromJson(Map<String, dynamic> json){
    StatusCode = json['StatusCode'];
    StatusMessage = json['StatusMessage']??'';
    TraceId = json['TraceId']??'';
    Body = PolyResponseBody.fromJson(json['Body']);
  }



  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = StatusCode;
    _data['StatusMessage'] = StatusMessage;
    _data['TraceId'] = TraceId;
    _data['Body'] = Body.toJson();
    return _data;
  }
}



class PolyResponseBody {
  PolyResponseBody({
    required this.success,
    required this.navigateURL,
    required this.errorCode,
    required this.errorMessage,
    required this.transactionRefNo,
  });
  late final String success;
  late final String navigateURL;
  late final String errorCode;
  late final String errorMessage;
  late final String transactionRefNo;

  PolyResponseBody.fromJson(Map<String, dynamic> json){
    Logger().i(json);
    success = json['success'].toString();
    navigateURL = json['navigateURL'];
    errorCode = json['errorCode'].toString();
    errorMessage = json['errorMessage']??'';
    transactionRefNo = json['transactionRefNo']??'';
  }



  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['navigateURL'] = navigateURL;
    _data['errorCode'] = errorCode;
    _data['errorMessage'] = errorMessage;
    _data['transactionRefNo'] = transactionRefNo;
    return _data;
  }
}