



import 'package:logger/logger.dart';

class GetTransactionByTxnResponseModel {
  GetTransactionByTxnResponseModel({
    required this.id,
    required this.txn,
    required this.iban,
    required this.bankCode,
    required this.deliveredAmount,
    required this.totalFee,
    required this.sendingAmount,
    required this.senderCardId,
    required this.foreignAmount,
    required this.exchangeRate,
    required this.foreignCurrency,
    required this.countrySvg,
    required this.receiverId,
    required this.receiverBankAccountId,
    required this.receiverName,
    required this.payoutMethod,
    required this.payoutMethodId,
    required this.payoutMethodFee,
    required this.payoutPartner,
    required this.payoutPartnerId,
    required this.payoutPartnerFee,
    required this.paymentGateway,
    required this.paymentGatewayId,
    required this.paymentGatewayFee,
    required this.bankName,
    required this.accountNo,
    required this.date,
    required this.time,
    required this.status,
    required this.statusList,
    required this.isReceiverDeleted,
    required this.bankDetails,
    required this.reason,
    required this.adminFee,
    required this.receiverCountryCurrencyID,
    required this.beneficiaryAccountNumber,
    required this.beneficiaryAddress,
    required this.beneficiaryBankBranchCode,
    required this.beneficiaryBankName,
    required this.beneficiaryMobile,
    required this.beneficiaryName,
    required this.senderAddress,
    required this.senderID,
    required this.senderName,
    required this.senderPhone,
  });
  late final String id;
  late final String txn;
  late final String iban;
  late final String bankCode;
  late final double deliveredAmount;
  late final double totalFee;
  late final double sendingAmount;
  late final String senderCardId;
  late final double foreignAmount;
  late final double exchangeRate;
  late final String foreignCurrency;
  late final String countrySvg;
  late final String receiverId;
  late final String receiverBankAccountId;
  late final String receiverName;
  late final String payoutMethod;
  late final String reason;
  late final String payoutMethodId;
  late final double payoutMethodFee;
  late final String payoutPartner;
  late final String payoutPartnerId;
  late final double payoutPartnerFee;
  late final String paymentGateway;
  late final String paymentGatewayId;
  late final double paymentGatewayFee;
  late final String bankName;
  late final String accountNo;
  late final double adminFee;
  late final String receiverCountryCurrencyID;
  late final String date;
  late final String time;
  late final String status;
  late final List<StatusList> statusList;
  late final bool isReceiverDeleted;
  late final BankDetails bankDetails;
  late final String beneficiaryName;
  late final String beneficiaryAddress;
  late final String beneficiaryMobile;
  late final String beneficiaryAccountNumber;
  late final String beneficiaryBankName;
  late final String beneficiaryBankBranchCode;
  late final String senderName;
  late final String senderAddress;
  late final String senderPhone;
  late final String senderID;

  GetTransactionByTxnResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    txn = json['txn'];
    iban = json['iban'];
    bankCode = json['bankCode'];
    deliveredAmount = json['deliveredAmount'];
    totalFee = json['totalFee'];
    sendingAmount = json['sendingAmount'];
    senderCardId = json['senderCardId'];
    foreignAmount = json['foreignAmount'];
    exchangeRate = json['exchangeRate'];
    foreignCurrency = json['foreignCurrency'];
    reason = json['reason'];
    countrySvg = json['countrySvg'];
    receiverId = json['receiverId'];
    receiverBankAccountId = json['receiverBankAccountId'];
    receiverName = json['receiverName'];
    payoutMethod = json['payoutMethod'];
    payoutMethodId = json['payoutMethodId'];
    payoutMethodFee = json['payoutMethodFee'];
    payoutPartner = json['payoutPartner'];
    payoutPartnerId = json['payoutPartnerId']??'';
    payoutPartnerFee = json['payoutPartnerFee'];
    paymentGateway = json['paymentGateway'];
    paymentGatewayId = json['paymentGatewayId'];
    paymentGatewayFee = json['paymentGatewayFee'];
    bankName = json['bankName'];
    accountNo = json['accountNo'];
    date = json['date'];
    time = json['time'];
    receiverCountryCurrencyID = json['receiverCountryCurrencyID'];
    adminFee = (json['adminFee'] as num).toDouble();
    status = json['status'];

    statusList =[];
    isReceiverDeleted = json['isReceiverDeleted'];
    bankDetails = BankDetails.fromJson(
      json['bankDetails'],

    );

    beneficiaryName = json['beneficiaryName'];
    beneficiaryAddress = json['beneficiaryAddress'];
    beneficiaryMobile = json['beneficiaryMobile'];
    beneficiaryAccountNumber = json['beneficiaryAccountNumber'];
    beneficiaryBankName = json['beneficiaryBankName'];
    beneficiaryBankBranchCode = json['beneficiaryBankBranchCode'];
    senderName = json['senderName'];
    senderAddress = json['senderAddress'];
    senderPhone = json['senderPhone'];
    senderID = json['senderID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['txn'] = txn;
    _data['iban'] = iban;
    _data['bankCode'] = bankCode;
    _data['deliveredAmount'] = deliveredAmount;
    _data['totalFee'] = totalFee;
    _data['sendingAmount'] = sendingAmount;
    _data['senderCardId'] = senderCardId;
    _data['foreignAmount'] = foreignAmount;
    _data['exchangeRate'] = exchangeRate;
    _data['foreignCurrency'] = foreignCurrency;
    _data['countrySvg'] = countrySvg;
    _data['receiverId'] = receiverId;
    _data['reason'] = reason;
    _data['receiverBankAccountId'] = receiverBankAccountId;
    _data['receiverName'] = receiverName;
    _data['payoutMethod'] = payoutMethod;
    _data['payoutMethodId'] = payoutMethodId;
    _data['payoutMethodFee'] = payoutMethodFee;
    _data['payoutPartner'] = payoutPartner;
    _data['payoutPartnerId'] = payoutPartnerId;
    _data['payoutPartnerFee'] = payoutPartnerFee;
    _data['paymentGateway'] = paymentGateway;
    _data['paymentGatewayId'] = paymentGatewayId;
    _data['paymentGatewayFee'] = paymentGatewayFee;
    _data['bankName'] = bankName;
    _data['accountNo'] = accountNo;
    _data['date'] = date;
    _data['time'] = time;
    _data['status'] = status;
    _data['statusList'] = [];
    _data['isReceiverDeleted'] = isReceiverDeleted;
    _data['bankDetails'] = bankDetails.toJson();
    return _data;
  }
}

class StatusList {
  StatusList({
    required this.date,
    required this.status,
  });
  late final String date;
  late final List<Status> status;

  StatusList.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    status = List.from(json['status']).map((e) => Status.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date;
    _data['status'] = status.map((e) => e.toJson()).toList();
    return _data;
  }
}

class BankDetails {
  BankDetails({
    required this.accountNo,
    required this.accountName,
    required this.txn,
  });
  late final String accountNo;
  late final String accountName;
  late final String txn;

  BankDetails.fromJson(Map<String, dynamic> json) {
    accountNo = json['accountNo'];
    accountName = json['accountName'];
    txn = json['txn'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['accountNo'] = accountNo;
    _data['accountName'] = accountName;
    _data['txn'] = txn;
    return _data;
  }
}

class Status {
  Status({
    required this.time,
    required this.text,
  });
  late final String time;
  late final String text;

  Status.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['time'] = time;
    _data['text'] = text;
    return _data;
  }
}
