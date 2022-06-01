import 'package:equatable/equatable.dart';

class ValidateBankResponseModel extends Equatable {
  ValidateBankResponseModel({
    required this.StatusCode,
    required this.StatusMessage,
    required this.TraceId,
    required this.validateBankResponseModelBody,
  });
  final String StatusCode;
  final String StatusMessage;
  final String TraceId;
  final ValidateBankResponseModelBody validateBankResponseModelBody;

  factory ValidateBankResponseModel.fromJson(Map<String, dynamic> json) {
    return ValidateBankResponseModel(
      StatusCode: json['StatusCode'],
      StatusMessage: json['StatusMessage'],
      TraceId: json['TraceId'],
      validateBankResponseModelBody: ValidateBankResponseModelBody.fromJson(json['Body']),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = StatusCode;
    _data['StatusMessage'] = StatusMessage;
    _data['TraceId'] = TraceId;
    _data['Body'] = validateBankResponseModelBody.toJson();
    return _data;
  }

  @override
  List<Object?> get props => [];
}

class ValidateBankResponseModelBody extends Equatable {
  ValidateBankResponseModelBody({
    required this.branchCode,
    required this.branchName,
    required this.city,
    required this.cnic,
    required this.titleOfAccount,
    required this.errors,
  });
  final String branchCode;
  final String branchName;
  final String city;
  final String cnic;
  final String titleOfAccount;
  final String errors;

  factory ValidateBankResponseModelBody.fromJson(Map<String, dynamic> json) {
    return ValidateBankResponseModelBody(
      branchCode: json['branchCode'],
      branchName: json['branchName'],
      city: json['city'],
      cnic: json['cnic'],
      titleOfAccount: json['titleOfAccount'],
      errors: json['errors'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['branchCode'] = branchCode;
    _data['branchName'] = branchName;
    _data['city'] = city;
    _data['cnic'] = cnic;
    _data['titleOfAccount'] = titleOfAccount;
    _data['errors'] = errors;
    return _data;
  }
}
