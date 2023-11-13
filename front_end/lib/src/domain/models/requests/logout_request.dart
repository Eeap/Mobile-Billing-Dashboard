import 'package:json_annotation/json_annotation.dart';
import '../../../utils/constants/strings.dart';

@JsonSerializable()
class LogoutRequest {
  final String email;

  LogoutRequest({
    this.email = defaultemail,
  });
  Map<String, dynamic> toJson() => {'email': email};
}
