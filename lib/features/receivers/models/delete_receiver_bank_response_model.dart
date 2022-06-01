import 'package:equatable/equatable.dart';

class DeleteReceiverBankListResponseModel extends Equatable{
  const DeleteReceiverBankListResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.deleteReceiverBankResponseBody,
  });
   final String statusCode;
   final String statusMessage;
   final String traceId;
   final DeleteReceiverBankResponseModelBody deleteReceiverBankResponseBody;

  factory DeleteReceiverBankListResponseModel.fromJson(Map<String, dynamic> json){
    return DeleteReceiverBankListResponseModel(
        statusCode : json['StatusCode'],
        statusMessage : json['StatusMessage'],
        traceId : json['TraceId'],
      deleteReceiverBankResponseBody : DeleteReceiverBankResponseModelBody.fromJson(json['Body']),);

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = deleteReceiverBankResponseBody.toJson();
    return _data;
  }

  @override
  List<Object?> get props => [statusCode,statusMessage ,traceId ,deleteReceiverBankResponseBody , ];
}

class DeleteReceiverBankResponseModelBody extends Equatable {
  const DeleteReceiverBankResponseModelBody({
    required this.result,
  });
   final bool result;

 factory DeleteReceiverBankResponseModelBody.fromJson(Map<String, dynamic> json){
   return DeleteReceiverBankResponseModelBody(
       result : json['result'],);

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['result'] = result;
    return _data;
  }

  @override List<Object?> get props => [result];
}