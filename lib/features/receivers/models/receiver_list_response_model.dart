import 'package:equatable/equatable.dart';

class ReceiverListResponseModel extends Equatable {
  const ReceiverListResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.receiverListBody,
  });

  final String statusCode;
  final String statusMessage;
  final String traceId;
  final List<ReceiverListBody> receiverListBody;

  factory ReceiverListResponseModel.fromJson(Map<String, dynamic> json) {
    return ReceiverListResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      receiverListBody: List.from(json['Body']).map((e) => ReceiverListBody.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = receiverListBody.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, traceId, receiverListBody];
}

class ReceiverListBody extends Equatable {
  const ReceiverListBody({
    required this.receiverId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.nickName,
    required this.email,
    required this.mobileNumber,
    required this.iso,
    required this.countryId,
    required this.svgPath,
    required this.banks,
  });

  final String receiverId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String nickName;
  final String email;
  final String mobileNumber;
  final String iso;
  final String countryId;
  final String svgPath;
  final List<ReceiverBank> banks;

  factory ReceiverListBody.fromJson(Map<String, dynamic> json) {
    return ReceiverListBody(
      receiverId: json['receiverId'],
      firstName: json['firstName'],
      middleName: json['middleName'] ?? 'N/A',
      lastName: json['lastName'],
      nickName: json['nickName'] ?? 'N/A',
      email: json['email'] ?? 'N/A',
      mobileNumber: json['mobileNumber'],
      iso: json['iso'],
      countryId: json['countryId'],
      svgPath: json['svgPath'],
      banks: List.from(json['banks']).map((e) => ReceiverBank.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['receiverId'] = receiverId;
    _data['firstName'] = firstName;
    _data['middleName'] = middleName;
    _data['lastName'] = lastName;
    _data['nickName'] = nickName;
    _data['email'] = email;
    _data['mobileNumber'] = mobileNumber;
    _data['iso'] = iso;
    _data['countryId'] = countryId;
    _data['svgPath'] = svgPath;
    _data['banks'] = banks.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  List<Object?> get props => [receiverId, firstName, middleName, lastName, nickName, email, mobileNumber, iso, countryId, banks, svgPath];
}

class ReceiverBank extends Equatable {
  const ReceiverBank({
    required this.id,
    required this.accountNumber,
    required this.accountTitle,
  });

  final String id;
  final String accountNumber;
  final String accountTitle;

  factory ReceiverBank.fromJson(Map<String, dynamic> json) {
    return ReceiverBank(
      id: json['id'],
      accountNumber: json['accountNumber'],
      accountTitle: json['accountTitle'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['accountNumber'] = accountNumber;
    _data['accountTitle'] = accountTitle;
    return _data;
  }

  @override
  List<Object?> get props => [id, accountNumber, accountTitle];
}
