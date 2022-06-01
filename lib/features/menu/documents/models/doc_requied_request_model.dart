import 'package:equatable/equatable.dart';

class DocumentRequiredRequestModel extends Equatable {
  const DocumentRequiredRequestModel({
    required this.id,
    required this.docNumber,
    required this.attachmentTypeId,
    required this.documentType,
    required this.createdBy,
    required this.expiryDate,
    required this.userId,
    required this.issuingAuthority,
    required this.issuingCountryId,
    required this.isIdentityId,
    required this.isRequired,
    required this.isActive,
    required this.remarks,
    required this.frontFileName,
    required this.backFileName,
    required this.frontFile,
    required this.backFile,
    required this.frontPath,
    required this.backPath,
  });
  final String id;
  final String frontFileName;
  final String backFileName;
  final String docNumber;
  final String frontPath;
  final String backPath;
  final String attachmentTypeId;
  final String documentType;
  final String userId;
  final String createdBy;
  final String expiryDate;
  final String issuingAuthority;
  final String issuingCountryId;
  final bool isIdentityId;
  final String frontFile;
  final String backFile;
  final bool isRequired;
  final bool isActive;
  final String remarks;

  factory DocumentRequiredRequestModel.fromJson(Map<String, dynamic> json) {
    return DocumentRequiredRequestModel(
      id: json['id'],
      docNumber: json['docNumber'],
      attachmentTypeId: json['attachmentTypeId'],
      documentType: json['documentType'],
      createdBy: json['createdBy'],
      expiryDate: json['expiryDate'],
      issuingAuthority: json['issuingAuthority'],
      issuingCountryId: json['issuingCountryId'],
      isIdentityId: json['isIdentityId'],
      userId: json['userId'],
      isRequired: json['isRequired'],
      isActive: json['isActive'],
      remarks: json['remarks'],
      frontFileName: json['frontFileName'],
      backFileName: json['backFileName'],
      frontFile: json['frontFile'],
      backFile: json['backFile'],
      frontPath: json['frontPath'],
      backPath: json['backPath'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['docNumber'] = docNumber;
    _data['attachmentTypeId'] = attachmentTypeId;
    _data['documentType'] = documentType;
    _data['userId'] = userId;
    _data['createdBy'] = createdBy;
    _data['expiryDate'] = expiryDate;
    _data['issuingAuthority'] = issuingAuthority;
    _data['issuingCountryId'] = issuingCountryId;
    _data['isIdentityId'] = isIdentityId;
    _data['userId'] = userId;
    _data['isRequired'] = isRequired;
    _data['isActive'] = isActive;
    _data['remarks'] = remarks;
    _data['frontFileName'] = frontFileName;
    _data['backFileName'] = backFileName;
    _data['frontFile'] = frontFile;
    _data['backFile'] = backFile;
    _data['frontPath'] = frontPath;
    _data['backPath'] = backPath;
    return _data;
  }

  @override
  List<Object?> get props => [
        id,
        docNumber,
        attachmentTypeId,
        documentType,
        userId,
        createdBy,
        expiryDate,
        issuingAuthority,
        issuingCountryId,
        isIdentityId,
        isRequired,
        isActive,
        remarks,
        frontFileName,
        backFileName,
        frontFile,
        backFile,
        frontPath,
        backPath,
      ];
}
