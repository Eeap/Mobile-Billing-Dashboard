import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserKeyResponse extends Equatable {
  final String message;

  UserKeyResponse({
    required this.message,
  });
  factory UserKeyResponse.fromJson(Map<String, dynamic> map) {
    return UserKeyResponse(
      message: map['message'] ?? "",
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [message];
}
