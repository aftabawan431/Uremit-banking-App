class GetAllCardsResponseModel {
  GetAllCardsResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.allCardsBody,
  });
  late final String statusCode;
  late final String statusMessage;
  late final String traceId;
  late final List<AllCardsBody> allCardsBody;

  GetAllCardsResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    statusMessage = json['StatusMessage'];
    traceId = json['TraceId'];
    allCardsBody = List.from(json['Body']).map((e) => AllCardsBody.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = allCardsBody.map((e) => e.toJson()).toList();
    return _data;
  }
}

class AllCardsBody {
  AllCardsBody({
    required this.id,
    required this.holder,
    required this.maskedNumber,
    required this.issuerCountry,
    required this.issureName,
    required this.expMonth,
    required this.expYear,
    required this.brand,
  });
  late final String id;
  late final String holder;
  late final String maskedNumber;
  late final String issuerCountry;
  late final String issureName;
  late final String expMonth;
  late final String expYear;
  late final String brand;

  AllCardsBody.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    holder = json['holder'];
    maskedNumber = json['masked_Number'];
    issuerCountry = json['issuer_country'];
    issureName = json['issure_name'];
    expMonth = json['exp_month'];
    expYear = json['exp_year'];
    brand = json['brand'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['holder'] = holder;
    _data['masked_Number'] = maskedNumber;
    _data['issuer_country'] = issuerCountry;
    _data['issure_name'] = issureName;
    _data['exp_month'] = expMonth;
    _data['exp_year'] = expYear;
    _data['brand'] = brand;
    return _data;
  }
}
