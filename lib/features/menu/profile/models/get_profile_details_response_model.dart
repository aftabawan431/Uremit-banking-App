import 'package:equatable/equatable.dart';

class GetProfileDetailsResponseModel extends Equatable {
  const GetProfileDetailsResponseModel({
    required this.StatusCode,
    required this.StatusMessage,
    required this.TraceId,
    required this.ProfileDetailsBody,
  });
  final String StatusCode;
  final String StatusMessage;
  final String TraceId;
  final ProfileDetailBody ProfileDetailsBody;

  factory GetProfileDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetProfileDetailsResponseModel(
      StatusCode: json['StatusCode'],
      StatusMessage: json['StatusMessage'],
      TraceId: json['TraceId'],
      ProfileDetailsBody: ProfileDetailBody.fromJson(json['Body']),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = StatusCode;
    _data['StatusMessage'] = StatusMessage;
    _data['TraceId'] = TraceId;
    _data['Body'] = ProfileDetailsBody.toJson();
    return _data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [StatusCode, StatusMessage, TraceId, ProfileDetailsBody];
}

class ProfileDetailBody extends Equatable {
  const ProfileDetailBody({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.birthCountryID,
    required this.birthCountry,
    required this.occupation,
    required this.nationalityCountryID,
    required this.nationalityCountry,
    required this.genderId,
    required this.phoneNumber,
    required this.dob,
    required this.address,
    required this.postalCode,
    required this.city,
    required this.provinceID,
    required this.province,
    required this.attachment1Id,
    required this.attachment1IdType,
    required this.attachment1Type,
    required this.frontFilePath,
    required this.frontFileName,
    required this.backFilePath,
    required this.backFileName,
    required this.expiryDate,
    required this.issuingAuthority,
    required this.issuingCountryID,
    required this.issuingCountry,
    required this.utilityBillPath,
    required this.utilityBillFileName,
    required this.attachment2Id,
    required this.attachment2IdType,
    required this.attachment2Type,
    required this.documentNumber,
  });
  final String firstName;
  final String middleName;
  final String lastName;
  final String birthCountryID;
  final String birthCountry;
  final String occupation;
  final String nationalityCountryID;
  final String nationalityCountry;
  final int genderId;
  final String phoneNumber;
  final String dob;
  final String address;
  final String postalCode;
  final String city;
  final String provinceID;
  final String province;
  final String attachment1Id;
  final String attachment1IdType;
  final String attachment1Type;
  final String frontFilePath;
  final String frontFileName;
  final String backFilePath;
  final String backFileName;
  final String expiryDate;
  final String issuingAuthority;
  final String issuingCountryID;
  final String issuingCountry;
  final String utilityBillPath;
  final String utilityBillFileName;
  final String attachment2Id;
  final String attachment2IdType;
  final String attachment2Type;
  final String documentNumber;

  factory ProfileDetailBody.fromJson(Map<String, dynamic> json) {
    return ProfileDetailBody(
      firstName: json['firstName'] ?? '',
      middleName: json['middleName'] ?? '',
      lastName: json['lastName'] ?? '',
      birthCountryID: json['birthCountryID'] ?? '',
      birthCountry: json['birthCountry'] ?? '',
      occupation: json['occupation'] ?? '',
      nationalityCountryID: json['nationalityCountryID'] ?? '',
      nationalityCountry: json['nationalityCountry'] ?? '',
      genderId: json['genderId'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      dob: json['dob'] ?? '',
      address: json['address'] ?? '',
      postalCode: json['postalCode'] ?? '',
      city: json['city'] ?? '',
      provinceID: json['provinceID'] ?? '',
      province: json['province'] ?? '',
      attachment1Id: json['attachment1Id'] ?? '',
      attachment1IdType: json['attachment1IdType'] ?? '',
      attachment1Type: json['attachment1Type'] ?? '',
      frontFilePath: json['frontFilePath'] ?? '',
      frontFileName: json['frontFileName'] ?? '',
      backFilePath: json['backFilePath'] ?? '',
      backFileName: json['backFileName'] ?? '',
      expiryDate: json['expiryDate'] ?? '',
      issuingAuthority: json['issuingAuthority'] ?? '',
      issuingCountryID: json['issuingCountryID'] ?? '',
      issuingCountry: json['issuingCountry'] ?? '',
      utilityBillPath: json['utilityBillPath'] ?? '',
      utilityBillFileName: json['utilityBillFileName'] ?? '',
      attachment2Id: json['attachment2Id'] ?? '',
      attachment2IdType: json['attachment2IdType'] ?? '',
      attachment2Type: json['attachment2Type'] ?? '',
      documentNumber: json['documentNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['firstName'] = firstName;
    _data['middleName'] = middleName;
    _data['lastName'] = lastName;
    _data['birthCountryID'] = birthCountryID;
    _data['birthCountry'] = birthCountry;
    _data['occupation'] = occupation;
    _data['nationalityCountryID'] = nationalityCountryID;
    _data['nationalityCountry'] = nationalityCountry;
    _data['genderId'] = genderId;
    _data['phoneNumber'] = phoneNumber;
    _data['dob'] = dob;
    _data['address'] = address;
    _data['postalCode'] = postalCode;
    _data['city'] = city;
    _data['provinceID'] = provinceID;
    _data['province'] = province;
    _data['attachment1Id'] = attachment1Id;
    _data['attachment1IdType'] = attachment1IdType;
    _data['attachment1Type'] = attachment1Type;
    _data['frontFilePath'] = frontFilePath;
    _data['frontFileName'] = frontFileName;
    _data['backFilePath'] = backFilePath;
    _data['backFileName'] = backFileName;
    _data['expiryDate'] = expiryDate;
    _data['issuingAuthority'] = issuingAuthority;
    _data['issuingCountryID'] = issuingCountryID;
    _data['issuingCountry'] = issuingCountry;
    _data['utilityBillPath'] = utilityBillPath;
    _data['utilityBillFileName'] = utilityBillFileName;
    _data['attachment2Id'] = attachment2Id;
    _data['attachment2IdType'] = attachment2IdType;
    _data['attachment2Type'] = attachment2Type;
    _data['documentNumber'] = documentNumber;
    return _data;
  }

  @override
  List<Object?> get props => [
        firstName,
        middleName,
        lastName,
        birthCountryID,
        birthCountry,
        occupation,
        nationalityCountryID,
        nationalityCountry,
        genderId,
        phoneNumber,
        dob,
        address,
        postalCode,
        city,
        provinceID,
        province,
        attachment1Id,
        attachment1IdType,
        attachment1Type,
        frontFilePath,
        frontFileName,
        backFilePath,
        backFileName,
        expiryDate,
        issuingAuthority,
        issuingCountryID,
        issuingCountry,
        utilityBillPath,
        utilityBillFileName,
        attachment2Id,
        attachment2IdType,
        attachment2Type,
        documentNumber
      ];
}
