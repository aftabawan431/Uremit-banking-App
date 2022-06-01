import 'package:equatable/equatable.dart';

class DeleteReceiverResponseModel extends Equatable {
  const DeleteReceiverResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.deleteReceiverResponseModelBody,
  });
  final String statusCode;
  final String statusMessage;
  final String traceId;
  final DeleteReceiverResponseModelBody deleteReceiverResponseModelBody;

  factory DeleteReceiverResponseModel.fromJson(Map<String, dynamic> json) {
    return DeleteReceiverResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      deleteReceiverResponseModelBody: DeleteReceiverResponseModelBody.fromJson(json['Body']),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = deleteReceiverResponseModelBody.toJson();
    return _data;
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, traceId, deleteReceiverResponseModelBody];
}

class DeleteReceiverResponseModelBody extends Equatable {
  const DeleteReceiverResponseModelBody({
    required this.deleteReceiver,
  });
  final bool deleteReceiver;

  factory DeleteReceiverResponseModelBody.fromJson(Map<String, dynamic> json) {
    return DeleteReceiverResponseModelBody(deleteReceiver: json['deleteReceiver']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['deleteReceiver'] = deleteReceiver;
    return _data;
  }

  @override
  List<Object?> get props => [deleteReceiver];
}
