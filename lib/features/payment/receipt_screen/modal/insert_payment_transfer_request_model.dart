class InsertPaymentTransferRequestModel {
  InsertPaymentTransferRequestModel(
      {required this.txn,
      required this.paymentGatewayId,
      required this.payoutMethodId,
      required this.sendingAmount,
      required this.payoutPartnerId,
      required this.deliveredAmount,
      required this.receivingAmount,
      required this.receivingCountryCurrencyId,
      required this.discount,
      required this.status,
      required this.receiverId,
      required this.receiverBankAccountId,
      required this.partnerTxn,
      required this.isIBFT,
      required this.ip,
      required this.date,
      required this.userId,
      required this.companyId,
      required this.senderCardId,
      required this.arrivingTime,
      required this.promoCode,
      required this.receiverCountryId,
      required this.isScheduled,
      required this.exchangeRate,
      required this.reason,
      required this.administrativeFee,
      required this.payoutPartnerFee,
      required this.payoutMethodFee,
      required this.paymentGatewayFee,
      required this.totalFee,
      required this.isSetToDraft,
      required this.id});
  late final String txn;
  late final String paymentGatewayId;
  late final String payoutMethodId;
  late final double sendingAmount;
  late final String payoutPartnerId;
  late final double deliveredAmount;
  late final double receivingAmount;
  late final String receivingCountryCurrencyId;
  late final double discount;
  late final int status;
  late final String receiverId;
  late final String receiverBankAccountId;
  late final String partnerTxn;
  late final bool isIBFT;
  late final String ip;
  late final String date;
  late final String userId;
  late final String companyId;
  late final String senderCardId;
  late final int arrivingTime;
  late final String promoCode;
  late final String receiverCountryId;
  late final bool isScheduled;
  late final double exchangeRate;
  late final String reason;
  late final double administrativeFee;
  late final double payoutPartnerFee;
  late final double payoutMethodFee;
  late final double paymentGatewayFee;
  late final double totalFee;
  late final bool isSetToDraft;
  String? id;

  InsertPaymentTransferRequestModel.fromJson(Map<String, dynamic> json) {
    txn = json['txn'];
    paymentGatewayId = json['paymentGatewayId'];
    payoutMethodId = json['payoutMethodId'];
    sendingAmount = json['sendingAmount'];
    payoutPartnerId = json['payoutPartnerId'];
    deliveredAmount = json['deliveredAmount'];
    receivingAmount = json['receivingAmount'];
    receivingCountryCurrencyId = json['receivingCountryCurrencyId'];
    discount = json['discount'];
    status = json['status'];
    receiverId = json['receiverId'];
    receiverBankAccountId = json['receiverBankAccountId'];
    partnerTxn = json['partnerTxn'];
    isIBFT = json['isIBFT'];
    ip = json['ip']??'0.0.0.0';
    date = json['date'];
    userId = json['userId'];
    companyId = json['companyId'];
    senderCardId = json['senderCardId'];
    arrivingTime = json['arrivingTime'];
    promoCode = json['promoCode'];
    receiverCountryId = json['receiverCountryId'];
    isScheduled = json['isScheduled'];
    exchangeRate = json['exchangeRate'];
    reason = json['reason'];
    administrativeFee = json['administrativeFee'];
    payoutPartnerFee = json['payoutPartnerFee'];
    payoutMethodFee = json['payoutMethodFee'];
    paymentGatewayFee = json['paymentGatewayFee'];
    totalFee = json['totalFee'];
    isSetToDraft = json['isSetToDraft'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['txn'] = txn;
    _data['paymentGatewayId'] = paymentGatewayId;
    _data['payoutMethodId'] = payoutMethodId;
    _data['sendingAmount'] = sendingAmount;
    _data['payoutPartnerId'] = payoutPartnerId;
    _data['deliveredAmount'] = deliveredAmount;
    _data['receivingAmount'] = receivingAmount;
    _data['receivingCountryCurrencyId'] = receivingCountryCurrencyId;
    _data['discount'] = discount;
    _data['status'] = status;
    _data['receiverId'] = receiverId;
    _data['receiverBankAccountId'] = receiverBankAccountId;
    _data['partnerTxn'] = partnerTxn;
    _data['isIBFT'] = isIBFT;
    _data['ip'] = ip;
    _data['date'] = date;
    _data['userId'] = userId;
    _data['companyId'] = companyId;
    _data['senderCardId'] = senderCardId;
    _data['arrivingTime'] = arrivingTime;
    _data['promoCode'] = promoCode;
    _data['receiverCountryId'] = receiverCountryId;
    _data['isScheduled'] = isScheduled;
    _data['exchangeRate'] = exchangeRate;
    _data['reason'] = reason;
    _data['administrativeFee'] = administrativeFee;
    _data['payoutPartnerFee'] = payoutPartnerFee;
    _data['payoutMethodFee'] = payoutMethodFee;
    _data['paymentGatewayFee'] = paymentGatewayFee;
    _data['totalFee'] = totalFee;
    _data['isSetToDraft'] = isSetToDraft;
    _data['id'] = id;
    return _data;
  }
}
