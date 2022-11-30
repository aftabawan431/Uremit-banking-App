class InsertPaymentProofResponseModal {
  InsertPaymentProofResponseModal({
    required this.StatusCode,
    required this.StatusMessage,
    required this.TraceId,
    required this.Body,
  });
  late final String StatusCode;
  late final String StatusMessage;
  late final String TraceId;
  late final String Body;


  InsertPaymentProofResponseModal.fromJson(Map<String, dynamic> json){
    StatusCode = json['StatusCode'];
    StatusMessage = json['StatusMessage'];
    TraceId = json['TraceId'];
    Body = json['Body'];

  }


}