class GetTransactionListResponseModel {
  GetTransactionListResponseModel({
    required this.StatusCode,
    required this.StatusMessage,
    required this.TraceId,
    required this.getTransactionListResponseModelBody,
  });
  late final String StatusCode;
  late final String StatusMessage;
  late final String TraceId;
  late final GetTransactionListResponseModelBody getTransactionListResponseModelBody;

  GetTransactionListResponseModel.fromJson(Map<String, dynamic> json){
    StatusCode = json['StatusCode'];
    StatusMessage = json['StatusMessage'];
    TraceId = json['TraceId'];
    getTransactionListResponseModelBody = GetTransactionListResponseModelBody.fromJson(json['Body']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = StatusCode;
    _data['StatusMessage'] = StatusMessage;
    _data['TraceId'] = TraceId;
    _data['Body'] = getTransactionListResponseModelBody.toJson();
    return _data;
  }
}

class GetTransactionListResponseModelBody {
  GetTransactionListResponseModelBody({
    required this.transactionList,
    required this.transactionsStats,
  });
  late final List<TransactionList> transactionList;
  late final TransactionsStats transactionsStats;

  GetTransactionListResponseModelBody.fromJson(Map<String, dynamic> json){
    transactionList = List.from(json['transactionList']).map((e)=>TransactionList.fromJson(e)).toList();
    transactionsStats = TransactionsStats.fromJson(json['transactionsStats']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['transactionList'] = transactionList.map((e)=>e.toJson()).toList();
    _data['transactionsStats'] = transactionsStats.toJson();
    return _data;
  }
}

class TransactionList {
  TransactionList({
    required this.id,
    required this.txn,
    required this.iban,
    required this.bankCode,
    required this.amount,
    required this.charges,
    required this.totalAmount,
    required this.foreignAmount,
    required this.exchnageRate,
    required this.foreignCurrency,
    required this.countrySvg,
    required this.receiverName,
    required this.payoutMethod,
    required this.payoutPartner,
    required this.paymentGateway,
    required this.bankName,
    required this.accountNo,
    required this.date,
    required this.time,
    required this.status,
    required this.statusList,
  });
  late final String id;
  late final String txn;
  late final String iban;
  late final String bankCode;
  late final double amount;
  late final double charges;
  late final double totalAmount;
  late final double foreignAmount;
  late final double exchnageRate;
  late final String foreignCurrency;
  late final String countrySvg;
  late final String receiverName;
  late final String payoutMethod;
  late final String payoutPartner;
  late final String paymentGateway;
  late final String bankName;
  late final String accountNo;
  late final String date;
  late final String time;
  late final String status;
  late final List<StatusList> statusList;

  TransactionList.fromJson(Map<String, dynamic> json){
    id = json['id'];
    txn = json['txn'];
    iban = json['iban'];
    bankCode = json['bankCode'];
    amount = (json['amount'] as num).toDouble();
    charges = (json['charges'] as num).toDouble();
    totalAmount = (json['totalAmount'] as num).toDouble();
    foreignAmount = (json['foreignAmount'] as num).toDouble();
    exchnageRate = (json['exchnageRate'] as num).toDouble();
    foreignCurrency = json['foreignCurrency'];
    countrySvg = json['countrySvg'];
    receiverName = json['receiverName'];
    payoutMethod = json['payoutMethod'];
    payoutPartner = json['payoutPartner'];
    paymentGateway = json['paymentGateway'];
    bankName = json['bankName'];
    accountNo = json['accountNo'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    statusList = List.from(json['statusList']).map((e)=>StatusList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['txn'] = txn;
    _data['iban'] = iban;
    _data['bankCode'] = bankCode;
    _data['amount'] = amount;
    _data['charges'] = charges;
    _data['totalAmount'] = totalAmount;
    _data['foreignAmount'] = foreignAmount;
    _data['exchnageRate'] = exchnageRate;
    _data['foreignCurrency'] = foreignCurrency;
    _data['countrySvg'] = countrySvg;
    _data['receiverName'] = receiverName;
    _data['payoutMethod'] = payoutMethod;
    _data['payoutPartner'] = payoutPartner;
    _data['paymentGateway'] = paymentGateway;
    _data['bankName'] = bankName;
    _data['accountNo'] = accountNo;
    _data['date'] = date;
    _data['time'] = time;
    _data['status'] = status;
    _data['statusList'] = statusList.map((e)=>e.toJson()).toList();
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

  StatusList.fromJson(Map<String, dynamic> json){
    date = json['date'];
    status = List.from(json['status']).map((e)=>Status.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date;
    _data['status'] = status.map((e)=>e.toJson()).toList();
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

  Status.fromJson(Map<String, dynamic> json){
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

class TransactionsStats {
  TransactionsStats({
    required this.totalTransaction,
    required this.successfullTransaction,
    required this.pendingTransaction,
  });
  late final int totalTransaction;
  late final int successfullTransaction;
  late final int pendingTransaction;

  TransactionsStats.fromJson(Map<String, dynamic> json){
    totalTransaction = json['totalTransaction'];
    successfullTransaction = json['successfullTransaction'];
    pendingTransaction = json['pendingTransaction'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['totalTransaction'] = totalTransaction;
    _data['successfullTransaction'] = successfullTransaction;
    _data['pendingTransaction'] = pendingTransaction;
    return _data;
  }
}