import 'package:equatable/equatable.dart';

//!! this model can also be use for the the paymentPersonalDetails
class SetProfileDetailsRequestModel extends Equatable {
  const SetProfileDetailsRequestModel({
    required this.userId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.birthCountryId,
    required this.occupation,
    required this.nationalityCountryId,
    required this.genderId,
    required this.phoneNumber,
    required this.dob,
    required this.address,
    required this.postalCode,
    required this.city,
    required this.province,
    required this.attachment,
  });
  final String userId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String birthCountryId;
  final String occupation;
  final String nationalityCountryId;
  final int genderId;
  final String phoneNumber;
  final String dob;
  final String address;
  final String postalCode;
  final String city;
  final String province;
  final List<Attachment> attachment;

  factory SetProfileDetailsRequestModel.fromJson(Map<String, dynamic> json) {
    return SetProfileDetailsRequestModel(
      userId: json['userId'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      birthCountryId: json['birthCountryId'],
      occupation: json['occupation'],
      nationalityCountryId: json['nationalityCountryId'],
      genderId: json['genderId'],
      phoneNumber: json['phoneNumber'],
      dob: json['dob'],
      address: json['address'],
      postalCode: json['postalCode'],
      city: json['city'],
      province: json['province'],
      attachment: List.from(json['attachment']).map((e) => Attachment.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['firstName'] = firstName;
    _data['middleName'] = middleName;
    _data['lastName'] = lastName;
    _data['birthCountryId'] = birthCountryId;
    _data['occupation'] = occupation;
    _data['nationalityCountryId'] = nationalityCountryId;
    _data['genderId'] = genderId;
    _data['phoneNumber'] = phoneNumber;
    _data['dob'] = dob;
    _data['address'] = address;
    _data['postalCode'] = postalCode;
    _data['city'] = city;
    _data['province'] = province;
    _data['attachment'] = attachment.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  List<Object?> get props => [
        userId,
        firstName,
        middleName,
        lastName,
        birthCountryId,
        occupation,
        genderId,
        nationalityCountryId,
        genderId,
        phoneNumber,
        dob,
        address,
        postalCode,
        city,
        province,
        attachment,
      ];
}

class Attachment extends Equatable {
  const Attachment({
    required this.id,
    required this.docNumber,
    required this.FrontPath,
    required this.BackPath,
    required this.attachmentTypeId,
    required this.documentType,
    required this.userId,
    required this.createdBy,
    required this.expiryDate,
    required this.issuingAuthority,
    required this.issuingCountryId,
    required this.isIdentityId,
    required this.FrontFileName,
    required this.BackFileName,
    required this.FrontFile,
    required this.BackFile,
    required this.isRequired,
    required this.isActive,
    required this.remarks,
  });
  final String id;

  final String docNumber;
  final String FrontPath;
  final String BackPath;
  final String attachmentTypeId;
  final String documentType;
  final String userId;
  final String createdBy;
  final String expiryDate;
  final String issuingAuthority;
  final String issuingCountryId;
  final bool isIdentityId;
  final String FrontFileName;
  final String BackFileName;
  final String FrontFile;
  final String BackFile;
  final bool isRequired;
  final bool isActive;
  final String remarks;

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'],
      docNumber: json['docNumber'],
      FrontPath: json['FrontPath'],
      BackPath: json['BackPath'],
      attachmentTypeId: json['attachmentTypeId'],
      documentType: json['documentType'],
      userId: json['userId'],
      createdBy: json['createdBy'],
      expiryDate: json['expiryDate'],
      issuingAuthority: json['issuingAuthority'],
      issuingCountryId: json['issuingCountryId'],
      isIdentityId: json['isIdentityId'],
      FrontFileName: json['FrontFileName'],
      BackFileName: json['BackFileName'],
      FrontFile: json['FrontFile'],
      BackFile: json['BackFile'],
      isRequired: json['isRequired'],
      isActive: json['isActive'],
      remarks: json['remarks'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['docNumber'] = docNumber;
    _data['FrontPath'] = FrontPath;
    _data['BackPath'] = BackPath;
    _data['attachmentTypeId'] = attachmentTypeId;
    _data['documentType'] = documentType;
    _data['userId'] = userId;
    _data['createdBy'] = createdBy;
    _data['expiryDate'] = expiryDate;
    _data['issuingAuthority'] = issuingAuthority;
    _data['issuingCountryId'] = issuingCountryId;
    _data['isIdentityId'] = isIdentityId;
    _data['FrontFileName'] = FrontFileName;
    _data['BackFileName'] = BackFileName;
    _data['FrontFile'] = FrontFile;
    _data['BackFile'] = BackFile;
    _data['isRequired'] = isRequired;
    _data['isActive'] = isActive;
    _data['remarks'] = remarks;
    return _data;
  }

  @override
  List<Object?> get props => [
        id,
        docNumber,
        FrontPath,
        BackPath,
        attachmentTypeId,
        userId,
        createdBy,
        expiryDate,
        issuingAuthority,
        issuingCountryId,
        isIdentityId,
        FrontFileName,
        BackFileName,
        FrontFile,
        BackFile,
        isRequired,
        isActive,
        remarks,
      ];
}
