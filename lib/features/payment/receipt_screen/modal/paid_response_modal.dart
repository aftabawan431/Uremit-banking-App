class PayIdBankResponseModal {
  PayIdBankResponseModal({
    required this.StatusCode,
    required this.StatusMessage,
    required this.TraceId,
    required this.Body,
  });
  late final String StatusCode;
  late final String StatusMessage;
  late final String TraceId;
  late final PayIdResponseBody Body;

  PayIdBankResponseModal.fromJson(Map<String, dynamic> json){
    StatusCode = json['StatusCode']??'';
    StatusMessage = json['StatusMessage']??'';
    TraceId = json['TraceId']??'';
    Body = PayIdResponseBody.fromJson(json['Body']);
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

class ManualBankResponseModal {
  ManualBankResponseModal({
    required this.StatusCode,
    required this.StatusMessage,
    required this.TraceId,
    required this.Body,
  });
  late final String StatusCode;
  late final String StatusMessage;
  late final String TraceId;
  late final ManualBankResponseBody Body;

  ManualBankResponseModal.fromJson(Map<String, dynamic> json){
    StatusCode = json['StatusCode']??'';
    StatusMessage = json['StatusMessage']??'';
    TraceId = json['TraceId']??'';
    Body = ManualBankResponseBody.fromJson(json['Body']);
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



class PayIdResponseBody {
  PayIdResponseBody({
    required this.payIDAccount,
    required this.accountName,
    required this.txn,
  });
  late final String payIDAccount;
  late final String accountName;
  late final String txn;

  PayIdResponseBody.fromJson(Map<String, dynamic> json){
    payIDAccount = json['payIDAccount']??'';
    accountName = json['accountName']??'';
    txn = json['txn']??'';
  }



  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['payIDAccount'] = payIDAccount;
    _data['accountName'] = accountName;
    _data['txn'] = txn;
    return _data;
  }
}
class ManualBankResponseBody {
  ManualBankResponseBody({
    required this.accountNo,
    required this.accountName,
    required this.txn,
  });
  late final String accountNo;
  late final String accountName;
  late final String txn;

  ManualBankResponseBody.fromJson(Map<String, dynamic> json){
    accountNo = json['accountNo']??'';
    accountName = json['accountName']??'';
    txn = json['txn']??'';
  }



  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['accountNo'] = accountNo;
    _data['accountName'] = accountName;
    _data['txn'] = txn;
    return _data;
  }
}