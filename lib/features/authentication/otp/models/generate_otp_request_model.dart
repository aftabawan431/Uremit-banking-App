import 'package:equatable/equatable.dart';

class GenerateOtpRequestModel extends Equatable {
  final String email;

  const GenerateOtpRequestModel(this.email);

  factory GenerateOtpRequestModel.fromJson(Map<String, dynamic> json) {
    return GenerateOtpRequestModel(json['email']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    return _data;
  }

  @override
  List<Object?> get props => [email];
}
