import '../../../utils/constants/nums.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../utils/constants/strings.dart';

@JsonSerializable()
class AlertSettingRequest {
  final String email;
  final String timeEnd;
  final int targetCount;

  AlertSettingRequest({
    this.email = defaultemail,
    this.timeEnd = "",
    this.targetCount = 0,
  });
  Map<String, dynamic> toJson() => {
        'timeEnd': timeEnd,
        'targetCount': targetCount,
        'email': email,
      };
}
