import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AlertSettingResponse extends Equatable {
  final String message;

  AlertSettingResponse({
    required this.message,
  });
  factory AlertSettingResponse.fromJson(Map<String, dynamic> map) {
    return AlertSettingResponse(
      message: map['message'] ?? "",
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [message];
}
