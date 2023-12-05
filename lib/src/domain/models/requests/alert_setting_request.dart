import 'package:json_annotation/json_annotation.dart';
import '../../../utils/constants/strings.dart';

@JsonSerializable()
class AlertSettingRequest {
  final String email;
  final String timeEnd;
  final int targetCost;

  AlertSettingRequest({
    this.email = defaultemail,
    this.timeEnd = "",
    this.targetCost = 0,
  });
  Map<String, dynamic> toJson() => {
        'timeEnd': timeEnd,
        'targetCost': targetCost,
        'email': email,
      };
}
