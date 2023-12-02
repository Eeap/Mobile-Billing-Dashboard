import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LoginResponse extends Equatable {
  final String message;

  LoginResponse({
    required this.message,
  });
  factory LoginResponse.fromJson(Map<String, dynamic> map) {
    return LoginResponse(
      message: map['message'] ?? "",
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [message];
}
