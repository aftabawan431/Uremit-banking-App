class GetProfileAdminApprovelResponseModel {
  GetProfileAdminApprovelResponseModel({
    required this.StatusCode,
    required this.StatusMessage,
    required this.TraceId,
    required this.body,
  });
  late final String StatusCode;
  late final String StatusMessage;
  late final String TraceId;
  late final GetProfileAdminApprovelBody body;

  GetProfileAdminApprovelResponseModel.fromJson(Map<String, dynamic> json) {
    StatusCode = json['StatusCode'];
    StatusMessage = json['StatusMessage'];
    TraceId = json['TraceId'];
    body = GetProfileAdminApprovelBody.fromJson(json['Body']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = StatusCode;
    _data['StatusMessage'] = StatusMessage;
    _data['TraceId'] = TraceId;
    _data['Body'] = body.toJson();
    return _data;
  }
}

class GetProfileAdminApprovelBody {
  GetProfileAdminApprovelBody({
    required this.isAdminApproved,
  });
  late final bool isAdminApproved;

  GetProfileAdminApprovelBody.fromJson(Map<String, dynamic> json) {
    isAdminApproved = json['isAdminApproved'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['isAdminApproved'] = isAdminApproved;
    return _data;
  }
}
