import 'package:json_annotation/json_annotation.dart';
import '../../../utils/constants/strings.dart';

@JsonSerializable()
class UserKeyRequest {
  final String email;
  final String accessKey;
  final String secretKey;

  UserKeyRequest({
    this.email = defaultemail,
    this.accessKey = "",
    this.secretKey = "",
  });
  Map<String, dynamic> toJson() =>
      {'accessKey': accessKey, 'secretKey': secretKey, 'email': email};
}
