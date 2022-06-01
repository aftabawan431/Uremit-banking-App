import 'package:equatable/equatable.dart';

class ReceiverAddResponseListModel extends Equatable {
  const ReceiverAddResponseListModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.receiverAddResponseListBody,
  });
  final String statusCode;
  final String statusMessage;
  final String traceId;
  final ReceiverAddResponseListBody receiverAddResponseListBody;

  factory ReceiverAddResponseListModel.fromJson(Map<String, dynamic> json) {
    return ReceiverAddResponseListModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      receiverAddResponseListBody: ReceiverAddResponseListBody.fromJson(json['Body']),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = receiverAddResponseListBody.toJson();
    return _data;
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, traceId, receiverAddResponseListBody];
}

class ReceiverAddResponseListBody extends Equatable {
  const ReceiverAddResponseListBody({
    required this.receiverID,
  });
  final String receiverID;

  factory ReceiverAddResponseListBody.fromJson(Map<String, dynamic> json) {
    return ReceiverAddResponseListBody(
      receiverID: json['receiverID'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['receiverID'] = receiverID;
    return _data;
  }

  @override
  List<Object?> get props => [receiverID];
}
