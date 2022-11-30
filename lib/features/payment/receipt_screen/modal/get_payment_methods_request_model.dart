class GetPaymentMethodsRequestModel {
  GetPaymentMethodsRequestModel({
    required this.payoutMethodID,
    required this.payoutPartnerID,
    required this.countryCurrencyID,
  });
  late final String payoutMethodID;
  late final String payoutPartnerID;
  late final String countryCurrencyID;

  GetPaymentMethodsRequestModel.fromJson(Map<String, dynamic> json){
    payoutMethodID = json['payoutMethodID'];
    payoutPartnerID = json['payoutPartnerID'];
    countryCurrencyID = json['countryCurrencyID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['payoutMethodID'] = payoutMethodID;
    _data['payoutPartnerID'] = payoutPartnerID;
    _data['countryCurrencyID'] = countryCurrencyID;
    return _data;
  }
}