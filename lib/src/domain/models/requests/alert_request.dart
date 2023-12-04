import 'package:json_annotation/json_annotation.dart';
import '../../../utils/constants/strings.dart';

@JsonSerializable()
class AlertRequest {
  final String email;

  AlertRequest({
    this.email = defaultemail,
  });
  Map<String, dynamic> toJson() => {
        'email': email,
      };
}
