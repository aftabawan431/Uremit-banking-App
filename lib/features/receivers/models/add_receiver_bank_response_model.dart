import 'package:equatable/equatable.dart';

class AddReceiverBankResponseModel extends Equatable {
  const AddReceiverBankResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.addReceiverBankResponseModelBody,
  });
  final String statusCode;
  final String statusMessage;
  final String traceId;
  final AddReceiverBankResponseModelBody addReceiverBankResponseModelBody;

  factory AddReceiverBankResponseModel.fromJson(Map<String, dynamic> json) {
    return AddReceiverBankResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      addReceiverBankResponseModelBody: AddReceiverBankResponseModelBody.fromJson(json['Body']),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = addReceiverBankResponseModelBody.toJson();
    return _data;
  }

  @override
  List<Object?> get props => [
        statusCode,
        statusMessage,
        traceId,
        addReceiverBankResponseModelBody,
      ];
}

class AddReceiverBankResponseModelBody extends Equatable {
  const AddReceiverBankResponseModelBody({
    required this.accountAdd,
  });
   final bool accountAdd;

 factory AddReceiverBankResponseModelBody.fromJson(Map<String, dynamic> json) {
   return AddReceiverBankResponseModelBody(
       accountAdd : json['accountAdd'],);

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['accountAdd'] = accountAdd;
    return _data;
  }

  @override
  List<Object?> get props => [accountAdd];
}
