import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SignUpResponse extends Equatable {
  final String message;

  SignUpResponse({
    required this.message,
  });
  factory SignUpResponse.fromJson(Map<String, dynamic> map) {
    return SignUpResponse(
      message: map['message'] ?? "",
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [message];
}
