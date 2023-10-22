import '../../../utils/constants/nums.dart';
import '../../../utils/constants/strings.dart';

class AwsResourceRequest {
  final String region;
  final int day;
  final String email;

  AwsResourceRequest(
      {this.region = defaultregion,
      this.day = defaultday,
      this.email = defaultemail});
}
