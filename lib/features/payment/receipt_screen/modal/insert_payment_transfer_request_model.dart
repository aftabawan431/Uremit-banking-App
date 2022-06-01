import 'package:equatable/equatable.dart';

class InsertPaymentTransferRequestModel extends Equatable {
  const InsertPaymentTransferRequestModel({
    required this.txn,
    required this.paymentGatewayId,
    required this.payoutMethodId,
    required this.sendingAmount,
    required this.payoutPartnerId,
    required this.sendingAmountWithFee,
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
  });
  final String txn;
  final String paymentGatewayId;
  final String payoutMethodId;
  final int sendingAmount;
  final String payoutPartnerId;
  final int sendingAmountWithFee;
  final int receivingAmount;
  final String receivingCountryCurrencyId;
  final int discount;
  final int status;
  final String receiverId;
  final String receiverBankAccountId;
  final String partnerTxn;
  final bool isIBFT;
  final String ip;
  final String date;
  final String userId;
  final String companyId;
  final String senderCardId;
  final int arrivingTime;
  final String promoCode;
  final String receiverCountryId;
  final bool isScheduled;
  final int exchangeRate;
  final String reason;
  final int administrativeFee;
  final int payoutPartnerFee;
  final int payoutMethodFee;
  final int paymentGatewayFee;
  final int totalFee;

  factory InsertPaymentTransferRequestModel.fromJson(
      Map<String, dynamic> json) {
    return InsertPaymentTransferRequestModel(
      txn: json['txn'],
      paymentGatewayId: json['paymentGatewayId'],
      payoutMethodId: json['payoutMethodId'],
      sendingAmount: json['sendingAmount'],
      payoutPartnerId: json['payoutPartnerId'],
      sendingAmountWithFee: json['sendingAmountWithFee'],
      receivingAmount: json['receivingAmount'],
      receivingCountryCurrencyId: json['receivingCountryCurrencyId'],
      discount: json['discount'],
      status: json['status'],
      receiverId: json['receiverId'],
      receiverBankAccountId: json['receiverBankAccountId'],
      partnerTxn: json['partnerTxn'],
      isIBFT: json['isIBFT'],
      ip: json['ip'],
      date: json['date'],
      userId: json['userId'],
      companyId: json['companyId'],
      senderCardId: json['senderCardId'],
      arrivingTime: json['arrivingTime'],
      promoCode: json['promoCode'],
      receiverCountryId: json['receiverCountryId'],
      isScheduled: json['isScheduled'],
      exchangeRate: json['exchangeRate'],
      reason: json['reason'],
      administrativeFee: json['administrativeFee'],
      payoutPartnerFee: json['payoutPartnerFee'],
      payoutMethodFee: json['payoutMethodFee'],
      paymentGatewayFee: json['paymentGatewayFee'],
      totalFee: json['totalFee'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['txn'] = txn;
    _data['paymentGatewayId'] = paymentGatewayId;
    _data['payoutMethodId'] = payoutMethodId;
    _data['sendingAmount'] = sendingAmount;
    _data['payoutPartnerId'] = payoutPartnerId;
    _data['sendingAmountWithFee'] = sendingAmountWithFee;
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
    return _data;
  }

  @override
  List<Object?> get props => [
        txn,
        paymentGatewayId,
        payoutMethodId,
        sendingAmount,
        payoutPartnerId,
        sendingAmountWithFee,
        receivingAmount,
        receivingCountryCurrencyId,
        discount,
        status,
        receiverId,
        receiverBankAccountId,
        partnerTxn,
        isIBFT,
        ip,
        date,
        userId,
        companyId,
        senderCardId,
        arrivingTime,
        promoCode,
        receiverCountryId,
        isScheduled,
        exchangeRate,
        reason,
        administrativeFee,
        payoutPartnerFee,
        payoutMethodFee,
        paymentGatewayFee,
        totalFee,
      ];
}
