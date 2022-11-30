
class GetTransactionByTxnRequestModel {
  GetTransactionByTxnRequestModel({
    required this.txn,
  });
  late final String txn;

  GetTransactionByTxnRequestModel.fromJson(Map<String, dynamic> json){
    txn = json['txn'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['txn'] = txn;
    return _data;
  }
}