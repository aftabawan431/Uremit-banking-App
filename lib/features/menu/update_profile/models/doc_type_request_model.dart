import 'package:equatable/equatable.dart';

class DocTypeRequestModel extends Equatable {
  final int isVisibleToClient;

  const DocTypeRequestModel(this.isVisibleToClient);

  factory DocTypeRequestModel.fromJson(Map<String, dynamic> json) {
    return DocTypeRequestModel(json['isVisibleToCLient']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['isVisibleToCLient'] = isVisibleToClient;
    return _data;
  }

  @override
  List<Object?> get props => [isVisibleToClient];
}
