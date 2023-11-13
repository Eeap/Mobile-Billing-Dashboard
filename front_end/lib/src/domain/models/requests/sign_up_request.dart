import 'package:json_annotation/json_annotation.dart';
import '../../../utils/constants/strings.dart';

@JsonSerializable()
class SignUpRequest {
  final String email;
  final String password;

  SignUpRequest({
    this.email = defaultemail,
    this.password = "",
  });
  Map<String, dynamic> toJson() => {'password': password, 'email': email};
}
