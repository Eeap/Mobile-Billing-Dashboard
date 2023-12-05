import 'package:json_annotation/json_annotation.dart';
import '../../../utils/constants/strings.dart';

@JsonSerializable()
class AwsResourceRequest {
  final String region;
  final int day;
  final String email;

  AwsResourceRequest({
    this.region = defaultregion,
    this.day = defaultday,
    this.email = defaultemail,
  });
  Map<String, dynamic> toJson() => {
        'region': region,
        'day': day,
        'email': email,
      };
}
