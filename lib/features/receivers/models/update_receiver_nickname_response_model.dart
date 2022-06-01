import 'package:equatable/equatable.dart';

class UpdateReceiverNicknameResponseModel extends Equatable {
  const UpdateReceiverNicknameResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.updateReceiverNicknameResponseBody,
  });
  final String statusCode;
  final String statusMessage;
  final String traceId;
  final UpdateReceiverNicknameResponseModelBody updateReceiverNicknameResponseBody;

  factory UpdateReceiverNicknameResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateReceiverNicknameResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      updateReceiverNicknameResponseBody: UpdateReceiverNicknameResponseModelBody.fromJson(json['Body']),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = updateReceiverNicknameResponseBody.toJson();
    return _data;
  }

  @override
  List<Object?> get props => [
        statusCode,
        statusMessage,
        traceId,
        updateReceiverNicknameResponseBody,
      ];
}

class UpdateReceiverNicknameResponseModelBody extends Equatable {
  const UpdateReceiverNicknameResponseModelBody({
    required this.result,
  });
  final bool result;

  factory UpdateReceiverNicknameResponseModelBody.fromJson(Map<String, dynamic> json) {
    return UpdateReceiverNicknameResponseModelBody(
      result: json['result'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['result'] = result;
    return _data;
  }

  @override
  List<Object?> get props => [result];
}
