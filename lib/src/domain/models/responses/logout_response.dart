import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LogoutResponse extends Equatable {
  final String message;

  LogoutResponse({
    required this.message,
  });
  factory LogoutResponse.fromJson(Map<String, dynamic> map) {
    return LogoutResponse(
      message: map['message'] ?? "",
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [message];
}
