class InsertPaymentProofRequestModal {
  InsertPaymentProofRequestModal({
    required this.txn,
    required this.userID,
    required this.document,
    required this.documentPath,
    required this.documentName,
  });
  late final String txn;
  late final String userID;
  late final String document;
  late final String documentPath;
  late final String documentName;

  InsertPaymentProofRequestModal.fromJson(Map<String, dynamic> json){
    txn = json['txn'];
    userID = json['userID'];
    document = json['document'];
    documentPath = json['documentPath'];
    documentName = json['documentName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['txn'] = txn;
    _data['userID'] = userID;
    _data['document'] = document;
    _data['documentPath'] = documentPath;
    _data['documentName'] = documentName;
    return _data;
  }
}