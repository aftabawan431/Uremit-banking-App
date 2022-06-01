import 'package:equatable/equatable.dart';

class GetPromotionListResponseModel extends Equatable {
  const GetPromotionListResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.traceId,
    required this.promotionListBody,
  });

  final String statusCode;
  final String statusMessage;
  final String traceId;
  final List<PromotionListBody> promotionListBody;

  factory GetPromotionListResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return GetPromotionListResponseModel(
      statusCode: json['StatusCode'],
      statusMessage: json['StatusMessage'],
      traceId: json['TraceId'],
      promotionListBody: List.from(json['Body']).map((e) => PromotionListBody.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = statusCode;
    _data['StatusMessage'] = statusMessage;
    _data['TraceId'] = traceId;
    _data['Body'] = promotionListBody.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, traceId, promotionListBody];
}

class PromotionListBody extends Equatable {
  const PromotionListBody({
    required this.id,
    required this.title,
    required this.content,
    required this.fileName,
  });
  final int id;
  final String title;
  final String content;
  final String fileName;

  factory PromotionListBody.fromJson(Map<String, dynamic> json) {
    return PromotionListBody(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      fileName: json['fileName'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['content'] = content;
    _data['fileName'] = fileName;
    return _data;
  }

  @override
  List<Object?> get props => [id, title, content, fileName];
}
