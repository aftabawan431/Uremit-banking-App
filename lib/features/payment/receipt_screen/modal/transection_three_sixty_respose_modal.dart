import 'package:uremit/utils/constants/app_level/app_url.dart';

class TransectionThreeSixtyResponseModal {
  TransectionThreeSixtyResponseModal({
    required this.StatusCode,
    required this.StatusMessage,
    required this.TraceId,
    required this.Body,
  });
  final String StatusCode;
  final String StatusMessage;
  final String TraceId;
  final TransectionThreeSixtyBody Body;

  factory TransectionThreeSixtyResponseModal.fromJson(
      Map<String, dynamic> json) {
    return TransectionThreeSixtyResponseModal(
        StatusCode: json['StatusCode'].toString(),
        StatusMessage: json['StatusMessage']??'',
        TraceId: json['TraceId']??'',
        Body: TransectionThreeSixtyBody.fromJson(json['Body']));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = StatusCode;
    _data['StatusMessage'] = StatusMessage;
    _data['TraceId'] = TraceId;
    _data['Body'] = Body.toJson();
    return _data;
  }
}

class TransectionThreeSixtyBody {
  TransectionThreeSixtyBody({
    required this.checkout,
    required this.txn,
  });
  final Checkout checkout;
  final String txn;

  factory TransectionThreeSixtyBody.fromJson(Map<String, dynamic> json) {
    return TransectionThreeSixtyBody(
        checkout: Checkout.fromJson(json['checkout']),
        txn:json['txn']

    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['checkout'] = checkout.toJson();
    _data['txn'] =txn;
    return _data;
  }
}


class Checkout {
  Checkout({
    required this.token,
  });
  late final String token;
  late final String redirect_url;

  Checkout.fromJson(Map<String, dynamic> json) {
    token = json['token']??'';
    redirect_url=json['redirect_url']??'';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    return _data;
  }
}
